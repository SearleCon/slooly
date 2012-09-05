class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :subject
      t.text :comment
      t.string :email

      t.timestamps
    end
  end
end
