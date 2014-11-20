require 'rails_helper'
require 'rake'


describe 'scheduler:send_reminders' do
  before(:all) do
    Slooly::Application.load_tasks
    @user = create(:user)
    @client = create(:client, user: @user)
  end

  it 'creates a history entry for the reminder' do
    invoice = create(:invoice)
    expect { Rake::Task['send_reminders'].execute }.to change { History.count }.by(1)
  end

  it 'does not send an email unless an invoice is in chasing or final_demand' do
    invoice = create(:invoice, status_id: [Invoice::STATUSES[:stop_chasing], Invoice::STATUSES[:paid],  Invoice::STATUSES[:write_off],  Invoice::STATUSES[:delete]].sample)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end


  it 'sends an email for invoices which are due' do
    invoice = create(:invoice)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'does not send an email for invoices which are due when due reminders is false' do
    invoice = create(:invoice)
    invoice.user.setting.update(due_reminder: false)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end

  it 'sends an email for invoices which are pre_due' do
    invoice = create(:invoice, :pre_due)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'does not send an email for invoices which are pre_due when pre_due_reminder is false' do
    invoice = create(:invoice, :pre_due)
    invoice.user.setting.update(pre_due_reminder: false)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(0)
  end

  it 'sends an email for invoices which are overdue1' do
    invoice = create(:invoice, :over_due1)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are overdue2' do
    invoice = create(:invoice, :over_due2)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are overdue3' do
    invoice = create(:invoice, :over_due3)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

  it 'sends an email for invoices which are in final demand' do
    invoice = create(:invoice, :final_demand)
    expect { Rake::Task['send_reminders'].execute }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end

end
