class AddInvoicesFkToHistories < ActiveRecord::Migration
  def change
    add_foreign_key :histories, :invoices, on_delete: :cascade
  end
end
