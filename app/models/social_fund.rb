class SocialFund < ActiveRecord::Base
	has_many :projects

	def self.update_social_fund(amount, category)
		fund = SocialFund.order("fiscal_year DESC").first
		unless fund.present?
			fund = SocialFund.new
			fund.fiscal_year = Date.today.year
			fund.save
		end
		cat = category.present? ? category.downcase : "others"
		current_fund = fund.send("fund_for_#{cat}")
		total_amount = current_fund + amount
		total_fund = fund.total_kitty_fund + total_amount
		fund.update_attributes({"fund_for_#{cat}" => total_amount, total_kitty_fund: total_fund})
		fund
	end
end