class AddOd2DateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :od2_date, :date
  end
end
