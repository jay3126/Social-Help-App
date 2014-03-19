class UsersController < ApplicationController

	def home
		@corporate_partners = User.includes(:logo).where(role: "Corporate")
		@registered_ngos = User.includes(:logo).where(Role: "NGO")
		render layout: false
	end

	def edit
		@user = current_user
	end

	def profile
		@logo = Logo.find_by(user_id: current_user.id)
		params[:nav] = "profile"
	end

	def dashboard
		if current_user.socialist?
			@issues_list = Issue.where(user_id: current_user.id)
			@total_issues = @issues_list.count
			@completed_issues = Issue.where(user_id: current_user.id, issue_status: Constants::IssueStatusConstant.all_to_hash[:closed]).count
			@pending_issues = Issue.where(user_id: current_user.id, issue_status: Constants::IssueStatusConstant.all_to_hash[:open]).count
		elsif current_user.corporate?
			@fiscal_stats = FiscalStat.where(user_id: current_user.id).order("fiscal_year desc")
		elsif current_user.ngo?
			# calculating total fund available/required by an NGO
			@total_required_fund = 0
			current_user.projects.each do |pr|
				@total_required_fund += pr.project_actual_cost
			end
			@avl_fund_for_ngo = 0
			# calculating project wise fund
			@project_wise_fund = []
			current_user.projects.each do |pr|
				project_detail = {}
				project_detail[:project_name] = pr.project_name
				temp = 0
				pr.project_funds.each do |pr_fund|
					temp += pr_fund.fund_amount
					@avl_fund_for_ngo += pr_fund.fund_amount	
				end
				project_detail[:project_fund] = temp
				@project_wise_fund << project_detail
			end
			@all_projects = Project.where(user_id: current_user.id)
			@completed_projects = @all_projects.where(user_id: current_user.id, project_status: Constants::ProjectStatusConstant.all_to_hash[:completed])
			@pending_projects = @all_projects.where(user_id: current_user.id, project_status: Constants::ProjectStatusConstant.all_to_hash[:in_progress])
		elsif current_user.analyst?
			@current_fund = SocialFund.order("fiscal_year DESC").first
			@all_projects = Project.all
			@completed_projects = @all_projects.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:completed])
			@pending_projects = @all_projects.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:in_progress])
			@pie_chart_data = ProjectFund.fund_used_stats().to_json
		elsif current_user.inspector?
			stats = Issue.select(:issue_status).group("issue_status").count
			@issue_stats = Hash.new(0)
			stats.each do |k,v|
				@issue_stats[k.downcase.split(" ").join("_")] = v
			end
		elsif current_user.donor?
			@donations = current_user.donations
			@total_donate = @donations.inject(0) {|s,d| s + d.amount}
			@donations_by_category = Hash.new(0)
			@donations.each do |d|
				@donations_by_category[d.category] += d.amount
			end
		end
		params[:nav] = "dashboard"
	end

	def update_profile
		@user = current_user
		if @user.update_without_password(user_profile_params)
			redirect_to profile_path
		else
			render action: :edit
		end
	end

	def change_image
		if params[:logo].present?
			logo = Logo.find_by(user_id: current_user.id)
			if logo.present?
				logo.update_attribute(:logo, params[:logo])
			else
				Logo.create(user_id: current_user.id, logo: params[:logo])
			end
		end
		redirect_to profile_path
	end

	#getting projects on the basis of their users
	def my_projects
		if params[:cat].present?
			st = params[:cat] == "in_progress" ? "in progress" : "completed"
			@my_projects = Project.where(user_id: current_user.id, project_status: st)
		else
			@my_projects = Project.where(user_id: current_user.id, project_status: "in progress")
		end
		@report_options = ProjectReport.previous_reports(current_user.id)
		@project_report = ProjectReport.new
	end

	def welfare_funds
		@fiscal_stats = FiscalStat.includes(:user).order("fiscal_year desc").load
		params[:nav] = "welfare-fund"
	end

	def donate
		if current_user
			@donation = Donation.new
			params[:cat] = "donate"
		else
			redirect_to new_user_registration_url(donor: "donor")
		end
	end

	def receive_donation
		@donation = Donation.new(donation_params)
		@donation.user_id = current_user.id
		if @donation.save
			SocialFund.update_social_fund(@donation.amount, @donation.category)
			redirect_to my_donations_url
		else
			render action: "donate"
		end
	end

	def my_donations
		@donations = current_user.donations
		@total_donate = @donations.inject(0) {|s,d| s + d.amount}
		@donations_by_category = Hash.new(0)
		@donations.each do |d|
			@donations_by_category[d.category] += d.amount
		end		
		params[:cat] = "my_donations"
	end

	def user_profile
		user = User.includes(:logo).find_by(id: params[:id])
		logo = "/assets/missing.jpg"
		if user.logo.present?
			logo = user.logo.logo.url(:thumb)
		end
		details = {
			role: user.role,
			email: user.email,
			name: user.name,
			address: user.address,
			city: user.city,
			phone_number: user.phone_number,
			pic: logo
		}
		details[:owner] = user.owner if user.ngo? or user.corporate?
		if user.socialist?
			details[:age] = user.age
			details[:gender] = user.gender
		end
		details[:service_type] = user.service_type if user.ngo?
		render json: details
	end

	private

	def user_profile_params
		params.require(:user).permit(:name, :address, :city, :pin_code, :state, :country, :mobile_number, :phone_number, :fax_number, :company_group, :tan_number, :no_of_employees, :age, :gender, :adhaar_number, :voter_id, :nationality, :pan_number, :service_type, :owner, :year_established, :website_address, :about)
	end

	def donation_params
		params.require(:donation).permit(:amount, :category)
	end

end