class AddUserIdIndexToCompanies < ActiveRecord::Migration
  def change
    add_index :companies, :user_id
  end
end
