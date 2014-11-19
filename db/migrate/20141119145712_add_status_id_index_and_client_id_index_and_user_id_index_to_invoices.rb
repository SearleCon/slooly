class AddStatusIdIndexAndClientIdIndexAndUserIdIndexToInvoices < ActiveRecord::Migration
  def change
    add_index :invoices, :status_id
    add_index :invoices, :client_id
    add_index :invoices, :user_id
  end
end
