class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :deliveries, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  enum is_active: {有効: true, 退会済み: false}




class Customer < ActiveRecord::Base
  composed_of :fullname,
       :class_name => "FullName",
       :mapping =>[
        [ :last_name, :family_name ],
        [ :first_name, :given_name ]
       ]

  composed_of :fullkananame,
       :class_name => "FullName",
       :mapping =>[
        [ :last_name, :family_name ],
        [ :first_name, :given_name ]]
end

class FullName
  attr_reader :family_name, :given_name

  def initialize(family_name, given_name)
    @family_name = family_name
    @given_name = given_name
  end

  def to_s
    [@family_name,@given_name].compact.join("")
  end
end

end
