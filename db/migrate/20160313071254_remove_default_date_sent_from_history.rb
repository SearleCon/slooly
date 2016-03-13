class RemoveDefaultDateSentFromHistory < ActiveRecord::Migration
  def change
    change_column_default :histories, :date_sent, nil
  end
end
