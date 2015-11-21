class AddDefaultsForVouchers < ActiveRecord::Migration
  def change
    change_column_default :vouchers, :number_of_days, 30
  end
end
