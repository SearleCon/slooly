class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :business_name
      t.string :contact_person
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
