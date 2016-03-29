class RemoveInvoiceFkFromHistories < ActiveRecord::Migration
  def change
    remove_foreign_key :histories, :invoices
  end
end
