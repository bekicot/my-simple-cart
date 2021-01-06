class AddIndexToForeignKeyTables < ActiveRecord::Migration[6.0]
  def change
    add_index :products, :store_id
    add_index :variant_options, :variant_id
    add_index :product_variant_details, :variant_id
    add_index :product_variant_details, :product_variant_id
    add_index :product_variant_details, :variant_option_id
    add_index :product_variants, :product_id
    add_index :product_variants, :sku, unique: true
    add_index :carts, :user_id
    add_index :carts, :store_id
    add_index :orders, :user_id
    add_index :orders, :store_id
    add_index :orders, :courier_id
    add_index :order_items, :order_id
    add_index :order_items, :product_variant_id

  end
end
