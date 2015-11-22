class RemoveUnnecessaryIndexes < ActiveRecord::Migration
  def change
    remove_index :clients, name: "business_name_idx"
    remove_index :clients, name: "contact_person_idx"
    remove_index :invoices, name: "description_idx"
    remove_index :invoices, name: "invoice_number_idx"
  end
end
