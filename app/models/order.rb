class Order < ApplicationRecord

	has_many :ordered_products
	belongs_to :customer

	# 注文ステータス 支払い方法
	enum ordered_status: {入金待ち: 0, 入金確認: 1, 製作中: 2, 発送準備中: 3, 発送済み: 4}
	enum is_credit: {銀行振込: true, クレジットカード: false}

# バリデーション
 #    VALID_ZIP_CODE = /\A\d{3}[-]\d{4}\z/
 #    validates :delivery_zip_code, presence: true, format: { with: VALID_ZIP_CODE, message: "はハイフンあり7桁で入力してください。" }
	# validates :delivery_name, presence: true
	# validates :delivery_address, presence: true


	# 注文個数#購入確定した後の定義
	def total_count#quantity
		total = 0#初期値の設定
		ordered_products.each do |ordered_product|
			total += ordered_product.quantity
		end
		total#最終的なトータル数量
	end

	# 注文合計金額
	def product_sum
		total = 0
		ordered_products.each do |ordered_product|
			total += ordered_product.price * ordered_product.quantity
		end
		total
	end

	# 請求金額
	def order_total
		product_sum + self.postage
	end


#---------↓　注文前　↓----------

	# 注文前の合計
	def cart_sum(user)#each文で変数使ってるので、最終的なtotalが必要
		total = 0
		user.cart_items.each do |cart_product|
			total += cart_product.product.tax_price * cart_product.quantity
		end
		total
	end

	# 注文前の請求金額#こっちはシンプルに足し算してるだけ。each文で使ってない
	def total(user)
		cart_sum(user) + self.postage_price
	end


	# 送料
	def postage_price
		postage_price = 800
	end




end
