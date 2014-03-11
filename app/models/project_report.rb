class ProjectReport < ActiveRecord::Base

	belongs_to :project
	belongs_to :user
	has_one :project_report_log

	def self.generate_report
		ProjectReport.includes(:project, :user).load
	end
end