class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.date :due_date
      t.decimal :amount
      t.text :description
      t.integer :status_id
      t.integer :client_id

      t.timestamps
    end
  end
end
