class Product < ApplicationRecord

	has_many :cart_items, dependent: :destroy#商品が色んなカスタマーのカートに入るイメージ
	has_many :orderd_products, dependent: :destroy#商品に対して色んなカスタマーが注文できるから
	belongs_to :genre#ジャンルは複数あるでしょ？

	attachment :image

	enum is_active: {販売中: true, 販売中止: false}
	validates :image, presence: true
	validates :name, presence: true
	validates :introduction, presence: true
	validates :genre_id, presence: true
	validates :price, presence: true


	def tax_price
		(price * Constants::TAX).round
	end
end
