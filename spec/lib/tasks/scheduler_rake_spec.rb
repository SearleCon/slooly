require 'rails_helper'
require 'rake'


describe 'scheduler:send_reminders' do


  before do
    Slooly::Application.load_tasks
    @user = create(:user)
    @client = create(:client, user: @user)
    Invoice.skip_callback(:save, :before, :calculate_dates)
  end

  after do
    Invoice.set_callback(:save, :before, :calculate_dates)
  end

  it 'creates a history entry for the reminder' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::Due.new(invoice))
    expect { Rake::Task['send_reminders'].execute }.to change { History.count }.by(1)
  end

  it 'updates the invoice last date sent' do
    invoice = create(:invoice, last_date_sent: nil)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::Due.new(invoice))

    Rake::Task['send_reminders'].execute
    invoice.reload
    expect(invoice.last_date_sent).to eq(Date.current)
  end

  it 'does not send an email unless an invoice is in chasing or final_demand' do
    invoice = create(:invoice, status: [:stop_chasing, :paid ,:write_off, :deleted].sample)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end


  it 'sends an email for invoices which are due' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::Due.new(invoice))
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'does not send an email for invoices which are due when due reminders is false' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::Due.new(invoice))
    allow_any_instance_of(Setting).to receive(:due_reminder).and_return(false)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end

  it 'sends an email for invoices which are pre_due' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::PreDue.new(invoice))
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'does not send an email for invoices which are pre_due when pre_due_reminder is false' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::PreDue.new(invoice))
    allow_any_instance_of(Setting).to receive(:pre_due_reminder).and_return(false)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end

  it 'sends an email for invoices which are overdue1' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::FirstOverDue.new(invoice))
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are overdue2' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::SecondOverDue.new(invoice))
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are overdue3' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::ThirdOverDue.new(invoice))
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are in final demand' do
    invoice = create(:invoice)
    allow(Invoice::Reminders).to receive(:new).and_return(Invoice::Reminders::FinalDemand.new(invoice))
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end
