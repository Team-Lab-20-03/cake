class OrderedProduct < ApplicationRecord

	belongs_to :product
	belongs_to :order

	enum create_status: {着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3}

	# 注文商品小計を定義
	def subtotal_price
		ordered_price * quantity
	end


	after_update do
    	order_products = self.order.ordered_products
    	 # 製作ステータスが1つでも製作中になる
    	if order_products.any? {|order_product| order_products.create_status == "製作中"} == true
      		self.order.update(ordered_status: "製作中") # 注文ステータスを製作中に変更する
      	 # 製作ステータスが全て製作完了になる
    	elsif order_products.all? {|order_product| order_products.create_status == "製作完了"} == true
    		self.order.update(ordered_status: "発送準備中") # 注文ステータスを発送準備中に変更する
    	end
    end

end
