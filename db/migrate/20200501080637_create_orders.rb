class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
			t.integer "customer_id"
			t.integer "ordered_status"
			t.integer "postage"
			t.integer "total_price"
			t.boolean "is_credit"
			t.string "delivery_name"
			t.string "delivery_zip_code"
			t.text "delivery_address"

      t.timestamps
    end
  end
end
