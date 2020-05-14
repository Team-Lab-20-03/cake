class ProductsController < ApplicationController

  def index

    @genre = Genre.where(is_active: true)# ジャンルが有効のみ

    if
      params[:genre_id]
      @products = Product.where(genre_id: params[:genre_id])
    else
      @products = Product.all
    end

  end

  def show

    @genre = Genre.where(is_active: true)# ジャンルが有効のみ
  	@product = Product.find(params[:id])
  	@cart_item = CartItem.new(product_id: @product.id)

  end

end