# == Schema Information
#
# Table name: clients
#
#  id             :integer          not null, primary key
#  business_name  :string(255)
#  contact_person :string(255)
#  address        :string(255)
#  city           :string(255)
#  post_code      :string(255)
#  telephone      :string(255)
#  fax            :string(255)
#  email          :string(255)
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

describe Client do
  it 'should have a valid factory' do
    client = build(:client)
    expect(client).to be_valid
  end

  it { should belong_to(:user).touch(true) }
  it { should have_many(:invoices) }
  it { should have_many(:histories) }

  it { should validate_presence_of(:business_name) }
  it { should validate_presence_of(:email) }
  it { should allow_value('paul@example.com', 'ken.john@fish.com').for(:email) }

  it 'should validate uniqueness of business_name scoped to user' do
    client = create(:client, business_name: 'Client')
    duplicate = create(:client, business_name: 'Client')
    should validate_uniqueness_of(:business_name).scoped_to(:user_id)
  end

  describe '#normalize_data' do
    it 'strips whitespaces from business_name' do
      client = build(:client)
      client.business_name = '  Test Business '
      expected = 'Test Business'
      client.send(:normalize_data)
      expect(client.business_name).to eq(expected)
    end

    it 'strips whitespaces from email' do
      client = build(:client)
      client.email = '  jim@example.com '
      expected = 'jim@example.com'
      client.send(:normalize_data)
      expect(client.email).to eq(expected)
    end
  end
end
