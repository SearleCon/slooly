class AddInvoiceIdToHistories < ActiveRecord::Migration
  def change
    add_reference :histories, :invoice, index: true, foreign_key: true
  end
end
