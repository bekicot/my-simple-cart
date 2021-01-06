class CreateVariantOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :variant_options do |t|
      t.integer :variant_id
      t.string :name
      t.timestamps
    end
  end
end
