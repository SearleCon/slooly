class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :logo_path
      t.string :address
      t.string :city
      t.string :post_code
      t.string :telephone
      t.string :fax
      t.string :email
      t.integer :user_id

      t.timestamps
    end
  end
end
