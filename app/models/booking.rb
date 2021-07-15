class Booking < ApplicationRecord
	belongs_to :airplane
	before_create :set_pnr
	validates :age, presence: true, numericality: { only_integer: true }
	validates :name,
          :presence => true,
          :length => { in: 2..20 }
	def set_pnr
		self.pnr = SecureRandom.urlsafe_base64(6)
	end
end
