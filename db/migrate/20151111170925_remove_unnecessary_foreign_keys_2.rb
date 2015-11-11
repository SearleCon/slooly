class RemoveUnnecessaryForeignKeys2 < ActiveRecord::Migration
  def change
    remove_foreign_key :invoices, :users
  end
end
