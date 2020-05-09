class HomeController < ApplicationController
  def top
  	@products = Product.page(params[:page]).reverse_order #変えてる
  	@genres = Genre.all
  end


end
