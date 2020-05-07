class ProductsController < ApplicationController

  def index

    @genre = Genre.where(is_active: true)# ジャンルが有効のみ

    if
      params[:genre_id]
      @products = Product.where(genre_id: params[:genre_id])
    else
      @products = Product.all
    end

      @genre = Genre.all

  end

  def show

    @genre = Genre.all
  	@product = Product.find(params[:id])
  	@cart_item = CartItem.new

  end

  end