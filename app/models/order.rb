class Order < ApplicationRecord

	has_many :orderd_products
	belongs_to :customer
end
