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

end
