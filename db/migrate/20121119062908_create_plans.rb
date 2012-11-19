class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :description
      t.integer :duration
      t.decimal :cost
      t.boolean :active

      t.timestamps
    end
  end
end
