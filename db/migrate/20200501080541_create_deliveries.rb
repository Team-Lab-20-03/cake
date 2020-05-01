class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
			t.integer "customer_id"
			t.string "destination_name"
			t.string "zip_code"
			t.text "address"

      t.timestamps
    end
  end
end
