class CreateProductVariantDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variant_details do |t|
      t.integer :variant_id
      t.integer :variant_option_id
      t.integer :product_variant_id
      t.timestamps
    end
  end
end
