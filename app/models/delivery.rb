class Delivery < ApplicationRecord

	belongs_to :customer

	def destination_info
		self.zip_code + self.address + self.destination_name
	end

	#住所バリデーション
    VALID_ZIP_CODE = /\A\d{3}[-]\d{4}\z/
    validates :zip_code, presence: true, format: { with: VALID_ZIP_CODE, message: "はハイフンあり7桁で入力してください。" }
    validates :address, presence: true
    validates :destination_name, presence: true

end
