class Delivery < ApplicationRecord

	belongs_to :customer

	def destination_info
		self.zip_code + self.address + self.destination_name
	end
end
