class CartItemsController < ApplicationController

	before_action :authenticate_customer!

	def index
		@customer = current_customer
	end

	def create
		if current_customer.cart_item.blank?
			@cart_item = current_customer.cart_items.new(cart_item_params)
		end
		@cart_item = CartItem.find(params[:id])
		@cart_item.quantity += params[:quantity].to_i
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
		@customer = Customer.find(current_customer.id)
		if customer.cart_items.destroy_all
			redirect_to cart_items_path
		else
			redirect_to cart_items_path
		end
	end

	private
	def cart_item_params
		params.require(:cart_item).permit(:quantity, :product_id)
	end

end