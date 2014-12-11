class RenameInvoiceStatusIdToStatus < ActiveRecord::Migration
  def change
    rename_column :invoices, :status_id, :status
  end
end
