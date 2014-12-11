# == Schema Information
#
# Table name: histories
#
#  id                :integer          not null, primary key
#  date_sent         :date
#  client_id         :integer
#  user_id           :integer
#  subject           :string(255)
#  message           :text
#  reminder_type     :string(255)
#  sent              :boolean
#  email_return_code :string(255)
#  email_sent_from   :string(255)
#  copy_email        :string(255)
#  email_sent_to     :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  invoice_number    :string(255)
#  email_from_name   :string(255)
#

describe History do
  it 'has a valid factory' do
    history = build(:history)
    expect(history).to be_valid
  end

  it { should belong_to(:user).touch(:true) }
  it { should belong_to(:client).touch(:true) }

end
