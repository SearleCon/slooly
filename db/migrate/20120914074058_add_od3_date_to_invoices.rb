class AddOd3DateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :od3_date, :date
  end
end
