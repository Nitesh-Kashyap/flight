class Payment < ApplicationRecord
	validates_presence_of :name, :card_number, :cvv, :month, :year
	validates :card_number, length: {is: 12}
	validates :cvv, length: {is: 3}
	validates :month,  inclusion: { in: 1..12, message: "must be in between 01 to 12" }
	validates :year, length: {is: 4}
	validates :year, 
	presence: true,
	inclusion: { in: Date.today.year .. Date.today.year + 15.year },
	format: { 
		with: /(19|20)\d{2}/i, 
		message: "should be greater or equal to #{Date.today.year}"
	}
end
