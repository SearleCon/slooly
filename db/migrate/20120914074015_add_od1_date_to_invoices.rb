class AddOd1DateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :od1_date, :date
  end
end
