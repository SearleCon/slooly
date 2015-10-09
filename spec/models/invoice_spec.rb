# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status         :integer
#  client_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

describe Invoice do

  before do
    User.skip_callback(:create, :after, :setup)
  end

  after do
    User.set_callback(:create, :after, :setup)
  end

  it { should belong_to(:client).touch(true) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:client) }
  it { should validate_presence_of(:invoice_number) }
  it { should validate_presence_of(:due_date) }
  it { should validate_numericality_of(:amount) }

  describe '.search' do
    let(:invoice) { create(:invoice, description: 'Shell', invoice_number: '123456') }

    it 'searches on description' do
      expect(Invoice.search('shell')).to eq [invoice]
    end

    it 'searches on invoice_number' do
      expect(Invoice.search('123456')).to eq [invoice]
    end
  end

  it 'returns an instance of Invoice::Age for age' do
    invoice = build(:invoice)
    expect(invoice.age).to be_an_instance_of(Invoice::Age)
  end

  describe '#set_defaults' do
    it 'sets a default status of chasing' do
      invoice = build(:invoice)
      invoice.send(:set_defaults)
      expect(invoice.chasing?).to be_truthy
    end
  end


  describe '#calculate_dates' do
    let (:invoice) { build(:invoice, due_date: Date.current)  }

    before do
      allow(invoice).to receive(:days_before_pre_due).and_return(1)
      allow(invoice).to receive(:days_between_chase).and_return(1)
      stub_const('Invoice::OVERDUE2_MODIFIER', 2)
      stub_const('Invoice::OVERDUE3_MODIFIER', 3)
    end

    it 'sets the predue date' do
      expect { invoice.send(:calculate_dates) }.to change(invoice, :pd_date).to(1.day.ago.to_date)
    end

    it 'sets the overdue1 date' do
      expect { invoice.send(:calculate_dates) }.to change(invoice, :od1_date).to(1.day.from_now.to_date)
    end

    it 'sets the overdue2 date' do
      expect { invoice.send(:calculate_dates) }.to change(invoice, :od2_date).to(2.days.from_now.to_date)
    end

    it 'sets the overdue3 date' do
      expect { invoice.send(:calculate_dates) }.to change(invoice, :od3_date).to(3.days.from_now.to_date)
    end
  end

  describe '#set_final_demand' do
    context 'invoice has a status of send_final_demand' do
      it 'sets a final demand date to the next day' do
        invoice = build(:invoice, status: :send_final_demand)
        invoice.send(:set_final_demand)
        expect(invoice.fd_date).to eql(Date.tomorrow)
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
