class AddPreDueDateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :pd_date, :date
  end
end
