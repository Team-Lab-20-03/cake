class ProductsController < ApplicationController

def index

	@genre = Genre.all

end

def show

	@product = Product.find(params[:id])
	@cart_item = CartItem.new(product_id: @product.id)
	@genre = Genre.all

end

end