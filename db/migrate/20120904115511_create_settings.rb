class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :send_from_name
      t.string :email_copy_to
      t.integer :days_between_chase
      t.integer :days_before_pre_due
      t.text :payment_method_message
      t.boolean :pre_due_reminder
      t.string :pre_due_subject
      t.text :pre_due_message
      t.boolean :due_reminder
      t.string :due_subject
      t.text :due_message
      t.string :overdue1_subject
      t.text :overdue1_message
      t.string :overdue2_subject
      t.text :overdue2_message
      t.string :overdue3_subject
      t.text :overdue3_message
      t.string :final_demand_subject
      t.text :final_demand_message
      t.integer :user_id

      t.timestamps
    end
  end
end
