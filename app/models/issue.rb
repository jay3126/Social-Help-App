class Issue < ActiveRecord::Base

	validates :issue_description, :issue_area, :issue_area_code, :category, presence: true

	has_and_belongs_to_many :users
	has_many :proposals

end