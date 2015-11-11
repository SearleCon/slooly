class RemoveUnnecessaryForeignKeys < ActiveRecord::Migration
  def change
    remove_foreign_key :histories, :users
  end
end
