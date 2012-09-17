class AddInvoiceNumberToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :invoice_number, :string
  end
end
