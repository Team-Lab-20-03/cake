class AddCustomerkaramsToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :first_name, :string
    add_column :customers, :last_name, :string
    add_column :customers, :kana_first_name, :string
    add_column :customers, :kana_last_name, :string
    add_column :customers, :phone_number, :string
    add_column :customers, :main_zip_code, :string
    add_column :customers, :main_address, :text
    add_column :customers, :is_active, :boolean
  end
end
