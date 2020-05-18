class Genre < ApplicationRecord

	has_many :products, dependent: :destroy#1がジャンル。

	enum is_active: {有効: true, 無効: false}

	# バリデーション
	validates :name, presence: true

end

