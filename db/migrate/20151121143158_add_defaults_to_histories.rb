class AddDefaultsToHistories < ActiveRecord::Migration
  def change
    change_column_default :histories, :date_sent, 'NOW()'
    change_column_default :histories, :sent, false
    change_column_default :histories, :email_return_code, 'Not yet sent'
  end
end
