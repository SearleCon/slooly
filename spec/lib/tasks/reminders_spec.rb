require 'rails_helper'
require 'rake'

describe 'reminders:send' do
  let!(:user) { create(:user) }
  let!(:setting) { create(:setting, user: user) }
  let!(:company) { create(:company, user: user) }
  let(:invoice) { create(:invoice, user: user) }
  let(:unsent_invoice) { create(:invoice, :unsent, user: user) }
  let(:non_chasing_invoice) { create(:invoice, :non_chasing, user: user) }

  before do
    Slooly::Application.load_tasks
  end

  it 'creates a history entry for the reminder' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::Due.new(invoice))
    expect { Rake::Task['reminders:send'].execute }.to change { History.count }.by(1)
  end

  it 'updates the invoice last date sent' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::Due.new(unsent_invoice))

    Rake::Task['reminders:send'].execute
    expect(unsent_invoice.reload.last_date_sent).to eq(Date.current)
  end

  it 'does not send an email unless an invoice is in chasing or final_demand' do
    create(:invoice, :non_chasing, user: user)
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end

  it 'sends an email for invoices which are due' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::Due.new(invoice))
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'does not send an email for invoices which are due when due reminders is false' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::Due.new(invoice))
    allow_any_instance_of(Setting).to receive(:due_reminder).and_return(false)
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end

  it 'sends an email for invoices which are pre_due' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::PreDue.new(invoice))
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'does not send an email for invoices which are pre_due when pre_due_reminder is false' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::PreDue.new(invoice))
    allow_any_instance_of(Setting).to receive(:pre_due_reminder).and_return(false)
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end

  it 'sends an email for invoices which are overdue1' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::FirstOverDue.new(invoice))
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are overdue2' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::SecondOverDue.new(invoice))
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are overdue3' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::ThirdOverDue.new(invoice))
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are in final demand' do
    allow(Invoices::Reminders).to receive(:new).and_return(Invoices::Reminders::FinalDemand.new(invoice))
    expect { Rake::Task['reminders:send'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end
