class CartItem < ApplicationRecord

	belongs_to :customer
	belongs_to :product


	def subtotal_price
		self.product.tax_price * self.quantity
	end



end
