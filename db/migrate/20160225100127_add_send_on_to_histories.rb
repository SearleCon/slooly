class AddSendOnToHistories < ActiveRecord::Migration
  def change
    add_column :histories, :send_on, :date
  end
end
