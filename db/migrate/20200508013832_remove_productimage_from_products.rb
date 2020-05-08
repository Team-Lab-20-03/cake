class RemoveProductimageFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :product_image, :string
  end
end
