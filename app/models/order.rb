class Order < ApplicationRecord

	has_many :orderd_products
	belongs_to :customer

	# 注文ステータス 支払い方法
	enum ordered_status: {入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}
	enum is_credit: {銀行振込: true, クレジットカード: false}

	# 注文個数
	def total_count
		total = 0
		ordered_products.each do |ordered_product|
			total += ordered_product.count
		end
		total
	end

	# 注文商品合計
	# def product_sum
	# 	total = 0
	# 	ordered_products.each do |ordered_product|
	# 		total += ordered_product.subtotal_price
	# 	end
	# 	total
	# end

	# 請求金額
	# def order_total
	# 	total = 0
	# 	ordered_products.each do |ordered_product|
	# 		total += ordered_product.subtotal_price
	# 	end
	# 	toral + postage
	# end
end
