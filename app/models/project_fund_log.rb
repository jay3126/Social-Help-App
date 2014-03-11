class ProjectFundLog < ActiveRecord::Base

	belongs_to :project

	def self.create(user, project_fund, category)
		log = ProjectFundLog.new
		log.project_id = project_fund.project_id
		log.user_id = user.id
		log.fund_amount = project_fund.fund_amount
		log.category = category
		log.save
	end
end