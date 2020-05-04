class Genre < ApplicationRecord

	has_many :products, dependent: :destroy
	enum is_active: {有効: true, 無効: false}
end

