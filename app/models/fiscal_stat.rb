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
			case self.pref_cat
			when "Any Cause"
				social_fund.fund_for_others += self.available_social_fund
			when "Children"
				social_fund.fund_for_children += self.available_social_fund
			when "Disabled"
				social_fund.fund_for_disabled += self.available_social_fund
			when "Education"
				social_fund.fund_for_education += self.available_social_fund
			when "Elderly"
				social_fund.fund_for_elderly += self.available_social_fund
			when "Employment"
				social_fund.fund_for_employment += self.available_social_fund
			when "Environment"
				social_fund.fund_for_environment += self.available_social_fund
			when "Health"
				social_fund.fund_for_health += self.available_social_fund
			when "Women"
				social_fund.fund_for_women += self.available_social_fund			
			when "Youth"
				social_fund.fund_for_youth += self.available_social_fund			
			end			
			social_fund.total_kitty_fund += self.available_social_fund
			social_fund.fund_remains += self.available_social_fund
			social_fund.save
		else
			# check for remaining balance of the previous year
			prev_social_fund = SocialFund.where(fiscal_year: self.fiscal_year - 1).first
			kitty_value = self.available_social_fund
			edu_value = self.pref_cat == "Education" ? self.available_social_fund : 0
			child_value = self.pref_cat == "Children" ? self.available_social_fund : 0
			women_value = self.pref_cat == "Women" ? self.available_social_fund : 0
			eld_value = self.pref_cat == "Elderly" ? self.available_social_fund : 0
			env_value = self.pref_cat == "Environment" ? self.available_social_fund : 0
			emp_value = self.pref_cat == "Employment" ? self.available_social_fund : 0
			othr_value = self.pref_cat == "Any Cause" ? self.available_social_fund : 0
			youth_value = self.pref_cat == "Youth" ? self.available_social_fund : 0
			dis_value = self.pref_cat == "Disabled" ? self.available_social_fund : 0
			hlt_value = self.pref_cat == "Health" ? self.available_social_fund : 0

			if prev_social_fund && prev_social_fund.fund_remains > 0
				kitty_value += prev_social_fund.fund_remains
				edu_value += prev_social_fund.fund_for_education
				child_value += prev_social_fund.fund_for_children
				women_value += prev_social_fund.fund_for_women
				eld_value += prev_social_fund.fund_for_elderly
				env_value += prev_social_fund.fund_for_environment
				emp_value += prev_social_fund.fund_for_employment
				othr_value += prev_social_fund.fund_for_others
				youth_value += prev_social_fund.fund_for_youth
				dis_value += prev_social_fund.fund_for_disabled
				hlt_value += prev_social_fund.fund_for_health																																			
			end
			SocialFund.create(fiscal_year: self.fiscal_year, total_kitty_fund: kitty_value, fund_remains: kitty_value, 
				fund_for_education: edu_value, fund_for_children: child_value, fund_for_women: women_value, fund_for_elderly: eld_value,
				fund_for_environment: env_value, fund_for_employment: emp_value, fund_for_others: othr_value, fund_for_youth: youth_value, 
				fund_for_disabled: dis_value, fund_for_health: hlt_value)
		end
	end
end