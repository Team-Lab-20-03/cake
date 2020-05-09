class CartItemsController < ApplicationController

	before_action :authenticate_customer!

	def index
		@customer = current_customer
	end

	def create
		@cart_item = CartItem.find_by(customer_id: current_customer.id, product_id: params[:cart_item][:product_id])
		if @cart_item
			@cart_item.quantity += params[:cart_item][:quantity].to_i
		else
			@cart_item = current_customer.cart_items.new(cart_item_params)
		end
		@cart_item.save
		redirect_to cart_items_path
	end

	def update
		cart_item = CartItem.find(params[:id])
		cart_item.update(cart_item_params)
		redirect_to cart_items_path
	end

	def destroy
		cart_item = CartItem.find(params[:id])
		cart_item.destroy
		redirect_to cart_items_path
	end

	def destroy_all
		current_customer.cart_items.destroy_all
		redirect_to cart_items_path
	end

	private
	def cart_item_params
		params.require(:cart_item).permit(:quantity, :product_id)
	end
end