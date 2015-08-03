require 'rails_helper'

feature 'Clients' do

  scenario 'User views clients' do
    user = create(:subscribed_user)
    login_as(user, scope: :user)

    client = create(:client, user: user)

    visit clients_path

    client_row = find("tr[data-client-id='#{client.id}']")

    expect(client_row.first('td')).to have_text(client.business_name.titleize)

  end

end