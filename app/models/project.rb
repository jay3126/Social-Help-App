class Project < ActiveRecord::Base
	belongs_to :social_fund
	belongs_to :user
end