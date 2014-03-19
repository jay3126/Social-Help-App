module Constants

	# eligibility criteria for a company to become eligible for this social help concept
	ELIGIBILITY_CRITERIA = 100000

	# percentage value the should be deducted from the net profit as social_fund
	SOCIALFUND_RATIO = 0.06

	#list of last 10 financial_years
	yr_range = []
	yr = Time.now.year - 2
	# for displaying last financial year only
	yr_range << (yr.to_s+'-'+(yr+1).to_s)

	# for displaying multiple financial years
	#((two_yr_bck - 1)..two_yr_bck).each do |yr|
	#	yr_range << (yr.to_s+'-'+(yr+1).to_s)
	#end

	FISCAL_YEAR = yr_range

	# valid currencies list
	VALID_CURRENCIES = ["INR"]

	#Roles
	ROLES = ["Corporate","NGO","Socialist","Analyst","Inspector","Donor"]

	class IssueCategoryConstant
		include Enum
		IssueCategoryConstant.define :others, "Others"
		IssueCategoryConstant.define :children, "Children"
		IssueCategoryConstant.define :disabled, "Disabled"
		IssueCategoryConstant.define :education, "Education"
		IssueCategoryConstant.define :elderly, "Elderly"
		IssueCategoryConstant.define :employment, "Employment"
		IssueCategoryConstant.define :environment, "Environment"
		IssueCategoryConstant.define :health, "Health"
		IssueCategoryConstant.define :women, "Women"
		IssueCategoryConstant.define :youth, "Youth"
	end

	class IssueStatusConstant
		include Enum
		IssueStatusConstant.define :review_pending, "Review Pending"
		IssueStatusConstant.define :approval_pending, "Approval Pending"
		IssueStatusConstant.define :approved, "Approved"
		IssueStatusConstant.define :rejected, "Rejected"
	end

	class ProjectStatusConstant
		include Enum
		ProjectStatusConstant.define :open, "Open"
		ProjectStatusConstant.define :in_progress, "In Progress"
		ProjectStatusConstant.define :completed, "Completed"
	end

	class ProposalStatusConstant
		include Enum
		ProposalStatusConstant.define :pending, "Pending"
		ProposalStatusConstant.define :approved, "Approved"
		ProposalStatusConstant.define :rejected, "Rejected"
	end

	class CategoryColorCodes
		include Enum
		CategoryColorCodes.define :others, "#68BC31"
		CategoryColorCodes.define :children, "#2091CF"
		CategoryColorCodes.define :disabled, "#AF4E96"
		CategoryColorCodes.define :education, "#DA5430"
		CategoryColorCodes.define :elderly, "#FEE074"
		CategoryColorCodes.define :employment, "#FEAD74"
		CategoryColorCodes.define :environment, "#AFE074"
		CategoryColorCodes.define :health, "#90E074"
		CategoryColorCodes.define :women, "#FEA074"
		CategoryColorCodes.define :youth, "#24E074"
	end
end