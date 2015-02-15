class ClientImporter < ActiveImporter::Base
  imports Client
  transactional

  column 'BusinessName', :business_name
  column 'Email', :email
  column 'ContactPerson', :contact_person, optional: true
  column 'Address', :address, optional: true
  column 'City', :city, optional: true
  column 'PostCode', :post_code, optional: true
  column 'Telephone', :telephone, optional: true
  column 'Fax', :fax, optional: true

  fetch_model do
    Client.find_or_initialize_by(business_name: row['BusinessName'], user_id: params[:user_id])
  end

end
