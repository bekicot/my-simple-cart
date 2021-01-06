class CreateCartItems < ActiveRecord::Migration[6.0]
  def change
    create_table :cart_items do |t|
      t.integer :cart_id
      t.integer :product_variant_id
      t.integer :quantity
      t.float :price
      t.float :discount
      t.float :total
      t.text :notes
      t.timestamps
    end
    add_index :cart_items, :cart_id
  end
end
