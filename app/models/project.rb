class Project < ActiveRecord::Base
	belongs_to :social_fund
	belongs_to :user

	after_create :update_kitty_amount

	private

	def update_kitty_amount
		project_cost = self.project_actual_cost
		scl_fund = SocialFund.order("fiscal_year DESC").first
		scl_fund.fund_used += project_cost
		scl_fund.fund_remains -= project_cost
		scl_fund.save
	end 
end