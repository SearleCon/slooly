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
      expect { invoice.send(:calculate_dates) }.to change(invoice, :pd_date).to(Date.yesterday)
    end

    it 'sets the overdue1 date' do
      expect { invoice.send(:calculate_dates) }.to change(invoice, :od1_date).to(Date.tomorrow)
    end

    it 'sets the overdue2 date' do
      expect { invoice.send(:calculate_dates) }.to change(invoice, :od2_date).to(2.days.from_now.to_date)
    end

    it 'sets the overdue3 date' do
      expect { invoice.send(:calculate_dates) }.to change(invoice, :od3_date).to(3.days.from_now.to_date)
    end
  end

  describe '#reschedule reminders' do
    context 'last date sent has changed' do
      it 'sets the invoice due date forward a month if the last_date_sent has changed' do
        invoice =  build(:invoice, due_date: Date.current, last_date_sent: Date.today)
        expect { invoice.send(:reschedule_reminder) }.to change(invoice, :due_date).to(1.month.from_now.to_date)
      end
    end

    context 'last date sent has not changed' do
      it 'does not change the due date' do
        invoice = build(:invoice, due_date: Date.current, last_date_sent: nil)
        expect { invoice.send(:reschedule_reminder) }.to_not change(invoice, :due_date)
      end
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