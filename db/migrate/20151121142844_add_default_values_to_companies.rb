class AddDefaultValuesToCompanies < ActiveRecord::Migration
  def change
    change_column_default :companies, :name, 'Your Company Name'
    change_column_default :companies, :address, '44 Street Name, Suburb'
    change_column_default :companies, :city, 'Best City'
    change_column_default :companies, :post_code, '1234'
    change_column_default :companies, :telephone, '555 345 6789'
    change_column_default :companies, :fax, 'People still fax?'
    change_column_default :companies, :email, 'you@example.com'
  end
end
