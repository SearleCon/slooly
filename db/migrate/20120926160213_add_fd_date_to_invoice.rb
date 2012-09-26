class AddFdDateToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :fd_date, :date
  end
end
