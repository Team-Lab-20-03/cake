class OrderedProduct < ApplicationRecord

	belongs_to :product
	belongs_to :order

	enum create_status: {着手不可: 0, 製作待ち: 1, 製作中: 2, 製作完了: 3}

	# 注文商品小計を定義
	def subtotal_price
		ordered_price * count
	end
end
