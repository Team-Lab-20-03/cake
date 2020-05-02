class Product < ApplicationRecord

	has_many :cart_items, dependent: :destroy
	has_many :orderd_products, dependent: :destroy
	belongs_to :genre

end
