class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.date :date_sent
      t.integer :client_id
      t.integer :user_id
      t.string :subject
      t.text :message
      t.string :reminder_type
      t.boolean :sent
      t.string :email_return_code
      t.string :email_sent_from
      t.string :copy_email
      t.string :email_sent_to

      t.timestamps
    end
  end
end
