# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status         :integer          default(2)
#  client_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

describe Invoice do
  before { User.skip_callback(:create, :after, :setup) }

  after { User.set_callback(:create, :after, :setup) }

  it { is_expected.to belong_to(:client).touch(true) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:client) }
  it { is_expected.to validate_presence_of(:invoice_number) }
  it { is_expected.to validate_presence_of(:due_date) }
  it { is_expected.to validate_numericality_of(:amount) }

  describe '.search' do
    let(:client) { create(:client, business_name: 'Shell', email: 'shell@example.com')}
    let(:invoice) { create(:invoice, description: 'Shell', invoice_number: '123456', client: client) }

    it 'searches on client' do
      expect(described_class.search('shell').result).to eq [invoice]
    end

    it 'searches on invoice_number' do
      expect(described_class.search('123456').result).to eq [invoice]
    end
  end



  describe '#calculate_dates' do
    let(:invoice) { build(:invoice, due_date: Date.current) }

    before do
      allow_any_instance_of(Setting).to receive(:days_before_pre_due).and_return(1)
      allow_any_instance_of(Setting).to receive(:days_between_chase).and_return(1)

      invoice.send(:calculate_dates)
    end

    it 'sets the predue date' do
      expect(invoice.pd_date).to eq(invoice.due_date.days_ago(1))
    end

    it 'sets the overdue1 date' do
      expect(invoice.od1_date).to eq(invoice.due_date.days_since(1))
    end

    it 'sets the overdue2 date' do
      expect(invoice.od2_date).to eq(invoice.od1_date.days_since(1))
    end

    it 'sets the overdue3 date' do
      expect(invoice.od3_date).to eq(invoice.od2_date.days_since(1))
    end
  end

  describe '#set_final_demand' do
    context 'invoice has a status of send_final_demand' do
      it 'sets a final demand date to the next day' do
        invoice = build(:invoice, status: :send_final_demand)
        invoice.send(:set_final_demand)
        expect(invoice.fd_date).to eql(Date.current.tomorrow)
      end
    end

    context 'invoice does not have a status of send_final_demand' do
      it 'does not set a final demand date' do
        invoice = build(:invoice, status: :chasing)
        invoice.send(:set_final_demand)
        expect(invoice.fd_date).to be_nil
      end
    end
  end
end
