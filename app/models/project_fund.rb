class ProjectFund < ActiveRecord::Base

	belongs_to :project
	belongs_to :project_report

	def self.release_fund(report_id,user)
    project_report = ProjectReport.includes(:project).find_by(id: report_id)

    total_project_cost = project_report.project.project_actual_cost

    deductable = 0
    all_funds = ProjectFund.where(project_id: project_report.project_id).order("fund_amount DESC")
    if all_funds.present?
    	deductable = all_funds.first.project_report.percent_done
    end

    # calculate percentage amount to release
    amount = total_project_cost * ((project_report.percent_done - deductable)/100.to_f)
    category = project_report.project.project_type

    res = deduct_fund(amount, category)
    if project_report.percent_done == 100
    	st = Constants::ProjectStatusConstant.all_to_hash[:completed]
    	Project.find_by(id: project_report.project_id).update_attributes({project_status: st,actual_completion_date: Date.today.to_date})
    end

    if res[:status] == 200
    	project_report.update_attribute(:fund_release, true)
	    project_fund = ProjectFund.new
	    project_fund.project_id = project_report.project_id
	    project_fund.project_report_id = report_id
	    project_fund.allocate_by = user.id
	    project_fund.fund_amount = amount
	    project_fund.allocate_date = Date.today
	    project_fund.save
	    ProjectFundLog.create(user, project_fund, category)
    end
    res
	end

	def self.deduct_fund(amount, category)
		fund_from_others_used = false
		r = {status: 200}
		social_fund = SocialFund.order("fiscal_year DESC").first
		fund_avail = social_fund.send("fund_for_#{category.downcase}")
		if fund_avail == 0 || fund_avail < amount
			fund_avail = social_fund.fund_for_others
			fund_from_others_used = true
		end
		if fund_avail < amount
			r[:status] = 500
			r[:message] = "Insufficient fund"
		else
			# update remaining fund as per category
			if fund_from_others_used
				social_fund.update_attribute("fund_for_others", (fund_avail - amount))
			else
				social_fund.update_attribute("fund_for_#{category.downcase}", (fund_avail - amount))
			end
			# update the total used/remaining fund also
			social_fund.fund_used += amount
			social_fund.fund_remains -= amount
			social_fund.save
		end
		r
	end

	def self.fund_used_stats
		r = []
		fund_used_category = Hash.new(0)
		funds = ProjectFund.includes(:project).select("project_id, sum(fund_amount) as used").where("YEAR(allocate_date) = #{Date.today.year}").group(:project_id)
		funds.each do |f|
			fund_used_category[f.project.project_type.downcase] += f.used
		end

		social_fund = SocialFund.order("fiscal_year desc").first
		if social_fund.present?
			Constants::IssueCategoryConstant.to_list.each do |c|
				avail = social_fund.send("fund_for_#{c.downcase}")
				used = avail > 0 ? ((fund_used_category[c.downcase]/avail.to_f) * 100) : 0.0
				r << {label: c, data: used, color: Constants::CategoryColorCodes.all_to_hash[c.downcase.to_sym]}
			end
		end
		r
	end

end