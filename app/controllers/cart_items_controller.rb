class CartItemsController < ApplicationController

	before_action :authenticate_customer!

def index

	@customer = Customer.find(current_customer.id)

end

def create

	@cart_item = current_customer.cart_items.new(cart_item_params)
	if @cart_item.save
	redirect_to cart_items_path
	end
end

def update

	@cart_item = CartItem.find(params[:id])
	@cart_item.update(cart_item_params)
	@customer = Customer.find(current_customer.id)
	redirect_to :index

end

def destroy

	@cart_item = CartItem.find(params[:id])
	@cart_item.destroy
	@customer = Customer.find(current_customer.id)
	redirect_to :index
end

def destroy_all

	@customer = Customer.find(current_customer.id)
	@customer.cart_items.destroy_all
	redirect_to :index

end