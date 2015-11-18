# == Schema Information
#
# Table name: histories
#
#  id                :integer          not null, primary key
#  date_sent         :date
#  client_id         :integer
#  subject           :string(255)
#  message           :text
#  reminder_type     :string(255)
#  sent              :boolean
#  email_return_code :string(255)
#  email_sent_from   :string(255)
#  copy_email        :string(255)
#  email_sent_to     :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  invoice_number    :string(255)
#  email_from_name   :string(255)
#

describe History do
  it { should belong_to(:client).touch(:true) }

  describe '#set_defaults' do
    it 'sets default values' do
      history = build(:history)
      history.send(:set_defaults)
      expect(history.date_sent).to eq(Date.current)
      expect(history.sent).to eq(false)
      expect(history.email_return_code).to eq('Not yet sent')
    end
  end

end
