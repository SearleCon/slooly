class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :unique_code
      t.integer :redeemed_by
      t.datetime :valid_until
      t.integer :number_of_days

      t.timestamps
    end
  end
end
