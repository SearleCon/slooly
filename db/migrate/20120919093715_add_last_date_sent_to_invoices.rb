class AddLastDateSentToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :last_date_sent, :date
  end
end
