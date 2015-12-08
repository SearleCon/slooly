# == Schema Information
#
# Table name: histories
#
#  id                :integer          not null, primary key
#  date_sent         :date             default(Sat, 21 Nov 2015)
#  client_id         :integer
#  subject           :string(255)
#  message           :text
#  reminder_type     :string(255)
#  sent              :boolean          default(FALSE)
#  email_return_code :string(255)      default("Not yet sent")
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
end
