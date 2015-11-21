class AddDefaultStatusToInvoices < ActiveRecord::Migration
  def change
    change_column_default :invoices, :status, 2
  end
end
