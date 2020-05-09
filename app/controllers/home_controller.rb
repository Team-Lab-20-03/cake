class HomeController < ApplicationController
  def top
  	@products = Product.all
  	@genres = Genre.all
  end


end
