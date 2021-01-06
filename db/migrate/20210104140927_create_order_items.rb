class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id
      t.integer :product_variant_id
      t.integer :quantity
      t.float :price
      t.float :discount
      t.float :total
      t.text :notes
      t.timestamps
    end
  end
end
