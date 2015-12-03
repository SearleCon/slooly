# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  address    :string(255)
#  city       :string(255)
#  post_code  :string(255)
#  telephone  :string(255)
#  fax        :string(255)
#  email      :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

describe Company do

  it { should belong_to(:user).touch(true) }

  it { should validate_presence_of(:email) }
  it { should allow_value('paul@example.com', 'ken.john@fish.com').for(:email) }

  it 'strips whitespaces from email' do
    company = create(:company, email: '  jim@example.com ')
    expected = 'jim@example.com'
    expect(company.email).to eq(expected)
  end

end
