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