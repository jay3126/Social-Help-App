class ProjectReport < ActiveRecord::Base

	belongs_to :project
	belongs_to :user

	def self.generate_report
		ProjectReport.includes(:project, :user).load
	end
end