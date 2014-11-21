class ClientImporter < ActiveImporter::Base
  imports Client

  column 'BusinessName', :business_name
  column 'Email', :email
  column 'ContactPerson', :contact_person, optional: true
  column 'Address', :address, optional: true
  column 'City', :city, optional: true
  column 'PostCode', :post_code, optional: true
  column 'Telephone', :telephone, optional: true
  column 'Fax', :fax, optional: true

  fetch_model do
    Client.where(business_name: row['business_name'], user_id: params[:user_id]).first_or_initialize
  end
end
