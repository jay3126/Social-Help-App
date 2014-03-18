class Project < ActiveRecord::Base

	belongs_to :user
	has_many :project_reports
	has_many :project_funds
	
end