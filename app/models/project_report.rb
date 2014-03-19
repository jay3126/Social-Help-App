class ProjectReport < ActiveRecord::Base

	belongs_to :project
	belongs_to :user
	has_one :project_fund
	has_one :project_report_log

	def self.generate_report
		ProjectReport.includes(:project, :user).load
	end

	def self.previous_reports(user_id)
		rp = ProjectReport.where(user_id: user_id, status: 'approved')
		max_report = Hash.new(0)
		rp.each do |r|
			max_report[r.project_id] = r.percent_done if max_report[r.project_id] < r.percent_done
		end
		max_report
	end

end