class UsersController < ApplicationController

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
			@current_fund = SocialFund.order("fiscal_year DESC").first
			@all_projects = Project.where(assigned_to: current_user.id)
			@completed_projects = @all_projects.where(assigned_to: current_user.id, project_status: Constants::ProjectStatusConstant.all_to_hash[:closed])
			@pending_projects = @all_projects.where(assigned_to: current_user.id, project_status: Constants::ProjectStatusConstant.all_to_hash[:in_progress])
		elsif current_user.analyst? || current_user.inspector?
			@current_fund = SocialFund.order("fiscal_year DESC").first
			@all_projects = Project.all
			@completed_projects = @all_projects.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:closed])
			@pending_projects = @all_projects.where(project_status: Constants::ProjectStatusConstant.all_to_hash[:in_progress])
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
		@my_projects = Project.where(user_id: current_user.id)
		params[:nav] = "my_project"
	end

	def welfare_funds
		@fiscal_stats = FiscalStat.includes(:user).order("fiscal_year desc").load
		params[:nav] = "welfare-fund"
	end

	private
	def user_profile_params
		params.require(:user).permit(:name, :address, :city, :pin_code, :state, :country, :mobile_number, :phone_number, :fax_number, :company_group, :tan_number, :no_of_employees, :age, :gender, :adhaar_number, :voter_id, :nationality, :pan_number, :service_type, :owner, :year_established)
	end

end