class CreateInvoices < ActiveRecord::Migration[6.0]
  def change
    create_table :invoices do |t|
      t.integer :user_id
      t.integer :pay_status
      t.datetime :pay_at
      t.integer :payment_type
      t.float :total
      t.timestamps
    end
    add_column :orders, :invoice_id, :integer
    add_index :orders, :invoice_id
  end
end
