class ChangeDefaultOfStatus < ActiveRecord::Migration[5.2]
  def up
  	change_column :customers,        :is_active, 		  :boolean, default: false, null: false
  	change_column :ordered_products, :create_status,  :integer, default: 0,     null: false
  	change_column :orders,					 :ordered_status, :integer, default: 0,     null: false
  	change_column :orders,					 :is_credit,		  :boolean, default: false, null: false
  	change_column :products,				 :is_active, 			:boolean, default: false, null: false
  	change_column :genres, 					 :is_active,      :boolean, default: false, null: false
  end
  def down
  	change_column :customers,				 :is_active,		  :boolean
  	change_column :ordered_products, :create_status,  :integer
  	change_column :orders,					 :ordered_status, :integer
  	change_column :orders,					 :is_credit,		  :boolean
  	change_column :products,				 :is_active,		  :boolean
  	change_column :genres,					 :is_active,		  :boolean
  end
end
