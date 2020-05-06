class CartItem < ApplicationRecord

	belongs_to :customer
	belongs_to :product


	def subtotal_price
		self.product.price * self.quantity
	end

end
