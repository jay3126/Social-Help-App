module Constants
	# eligibility criteria for a company to become eligible for this social help concept
	ELIGIBILITY_CRITERIA = 100000

	# percentage value the should be deducted from the net profit as social_fund
	SOCIALFUND_RATIO = 0.02

	#list of last 10 financial_years
	yr_range = []
	two_yr_bck = Time.now.year - 2
	((two_yr_bck - 9)..two_yr_bck).each do |yr|
		yr_range << (yr.to_s+'-'+(yr+1).to_s)
	end

	FISCAL_YEAR = yr_range

	# valid currencies list
	VALID_CURRENCIES = ["INR"]

end