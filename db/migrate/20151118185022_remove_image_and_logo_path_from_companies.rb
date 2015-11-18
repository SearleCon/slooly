class RemoveImageAndLogoPathFromCompanies < ActiveRecord::Migration
  def change
    remove_columns :companies, :image, :logo_path
  end
end
