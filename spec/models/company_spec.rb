# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  logo_path  :string(255)
#  address    :string(255)
#  city       :string(255)
#  post_code  :string(255)
#  telephone  :string(255)
#  fax        :string(255)
#  email      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  image      :string(255)
#

describe Company do
  it 'should have a valid factory' do
    company = build(:company)
    expect(company).to be_valid
  end

  it { should belong_to(:user).touch(true) }

  it { should validate_presence_of(:email) }
  it { should allow_value('paul@example.com', 'ken.john@fish.com').for(:email) }

  describe '#normalize_data' do
    it 'strips whitespaces from email' do
      company = build(:company)
      company.email = '  jim@example.com '
      expected = 'jim@example.com'
      company.send(:normalize_data)
      expect(company.email).to eq(expected)
    end
  end

  describe '#set_defaults' do
    it 'sets default values' do
      company = build(:company)
      company.send(:set_defaults)
      expect(company.name).to eq("Your Company Name")
      expect(company.address).to eq("44 Street Name, Suburb")
      expect(company.city).to eq("Best City")
      expect(company.post_code).to eq("1234")
      expect(company.telephone).to eq("555 345 6789")
      expect(company.fax).to eq("People still fax?")
      expect(company.email).to eq('you@example.com')
    end
  end





end
