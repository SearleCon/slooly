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
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

describe Client do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:invoices) }
  it { is_expected.to have_many(:histories) }

  it { is_expected.to validate_presence_of(:business_name) }
  it { is_expected.to validate_uniqueness_of(:business_name).scoped_to(:user_id) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to allow_value('paul@example.com', 'ken.john@fish.com').for(:email) }

  describe '.search' do

    let!(:client) { create(:client, business_name: 'Shell', contact_person: 'Peter') }

    it 'searches on business_name' do
      expect(described_class.search('shell')).to eq [client]
    end

    it 'searches on contact_person' do
      expect(described_class.search('peter')).to eq [client]
    end
  end
end
