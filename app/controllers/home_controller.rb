class HomeController < ApplicationController
  def top
  	@products = Product.page(params[:page]).reverse_order #ページネーション変えてる
  	@random = Product.order("RANDOM()").limit(4)#ランダム機能追加
  	@genres = Genre.all #Topにもジャンル検索項目を追加する。

  end


end
