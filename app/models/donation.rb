class Donation < ActiveRecord::Base

	belongs_to :user
	validates :amount, :category, presence: true
	validates :amount, numericality: { greater_than_or_equal_to: 100 }

end
