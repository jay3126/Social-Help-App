class FiscalStat < ActiveRecord::Base
	belongs_to :user

	after_create :update_kitty_fund, if: :eligible?

	validate :one_record_per_fiscal_year_per_company


	private

	def eligible?
		self.eligibility_status
	end

	def one_record_per_fiscal_year_per_company
		fis_stat = FiscalStat.where(fiscal_year: self.fiscal_year, user_id: self.user_id).first
		if fis_stat.present?
			self.errors.add :base, "Record For Given Financial Year Is Already Present"
		end
	end

	def update_kitty_fund
		# calculate the social_fund for company based of net profit
		calculated_value = self.net_profit * Constants::SOCIALFUND_RATIO
		self.update_attribute(:available_social_fund, calculated_value.to_f)

		# insert of update(if exist) social_funds's total_kitty_fund for a particular year based on companies fund
		social_fund = SocialFund.where(fiscal_year: self.fiscal_year).first
		# if present then will update kitty fund else will create new record
		if social_fund.present?
			social_fund.total_kitty_fund += self.available_social_fund
			social_fund.fund_remains.to_f += self.available_social_fund
			social_fund.save
		else
			SocialFund.create(fiscal_year: self.fiscal_year, total_kitty_fund: self.available_social_fund, fund_remains: self.available_social_fund)
		end
	end
end