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

FactoryGirl.define do
  factory :history do
    date_sent Date.current
    subject           { Faker::Lorem.sentence(3) }
    message           { Faker::Lorem.paragraph }
    reminder_type 'PD'
    sent false
    email_return_code '005'
    email_sent_from    { Faker::Internet.email }
    copy_email         { Faker::Internet.email }
    email_sent_to      { Faker::Internet.email }
    invoice_number '1'
    email_from_name { Faker::Name.name }
  end
end
