class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  enum is_active: {有効: true, 退会済み: false}

  # is_activeが有効の場合、sessionsコントローラへtrueを返す
 def active_for_authentication?
 	super && (self.is_active == '有効')
 end

  # カートアイテム内合計
	def cart_sum
		total = 0
		cart_items.each do |cart_product|
			total += cart_product.product.tax_price * cart_product.quantity
		end
		total
	end


  # sign_in,log_inバリデーション
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_KANA_REGEX = /\A[\p{katakana}\p{blank}ー－]+\z/
    VALID_PHONE_REGEX = /\A\d{10}$|^\d{11}\z/
    VALID_ZIP_CODE = /\A\d{3}[-]\d{4}\z/
      validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}
      validates :kana_first_name,:kana_last_name, presence: true, format: { with: VALID_KANA_REGEX, message: 'はカタカナで入力して下さい。'}
      validates :first_name, :last_name, presence: true
      validates :phone_number, presence: true, format: { with: VALID_PHONE_REGEX, message: 'ハイフンなしの10桁か11桁で入力して下さい。' }
      validates :main_zip_code, presence: true, format: { with: VALID_ZIP_CODE, message: "はハイフンあり7桁で入力してください。" }
      validates :main_address, presence: true

end
