# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)      default("Your Company Name")
#  address    :string(255)      default("44 Street Name, Suburb")
#  city       :string(255)      default("Best City")
#  post_code  :string(255)      default("1234")
#  telephone  :string(255)      default("555 345 6789")
#  fax        :string(255)      default("People still fax?")
#  email      :string(255)      default("you@example.com")
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
