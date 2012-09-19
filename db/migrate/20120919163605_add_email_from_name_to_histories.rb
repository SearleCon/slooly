class AddEmailFromNameToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :email_from_name, :string
  end
end
