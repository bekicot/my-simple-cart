class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :store_id
      t.integer :courier_id
      t.float :total_price
      t.float :delivery_cost
      t.float :total
      t.integer :status
      t.timestamps
    end
  end
end
