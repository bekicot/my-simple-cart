class CreateProductVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variants do |t|
      t.integer :product_id
      t.string :sku
      t.float :price
      t.integer :quantity
      t.float :discount
      t.timestamps
    end
  end
end
