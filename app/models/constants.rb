module Constants

	# eligibility criteria for a company to become eligible for this social help concept
	ELIGIBILITY_CRITERIA = 100000

	# percentage value the should be deducted from the net profit as social_fund
	SOCIALFUND_RATIO = 0.06

	#list of last 10 financial_years
	yr_range = []
	two_yr_bck = Time.now.year - 2
	((two_yr_bck - 4)..two_yr_bck).each do |yr|
		yr_range << (yr.to_s+'-'+(yr+1).to_s)
	end

	FISCAL_YEAR = yr_range

	# valid currencies list
	VALID_CURRENCIES = ["INR"]

	# valid categories
	VALID_CATEGORIES = ["Any Cause", "Children", "Disabled", "Education", "Elderly", "Employment", "Environment", "Health", "Women", "Youth"]

	class IssueStatusConstant
		include Enum
		IssueStatusConstant.define :open, "Open"
		IssueStatusConstant.define :assigned, "Assigned"
		IssueStatusConstant.define :closed, "Closed"
		IssueStatusConstant.define :approved, "Approved"
		IssueStatusConstant.define :rejected, "Rejected"
	end

	class ProjectStatusConstant
		include Enum
		ProjectStatusConstant.define :in_progress, "In Progress"
		ProjectStatusConstant.define :approved, "Approved"
		ProjectStatusConstant.define :closed, "Closed"
	end
end