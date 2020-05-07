class CartItem < ApplicationRecord

	belongs_to :customer
	belongs_to :product


	def subtotal_price
		self.product.tax_price * self.quantity
	end

	def cart_sum(user)
		total = 0
		user.cart_items.each do |cart_product|
			total += cart_product.product.tax_price
		end
		total
	end



end
