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

FactoryGirl.define do
  before(:create) { Invoice.skip_callback(:save, :before, :calculate_dates) }
  after(:create)  { Invoice.set_callback(:save, :before, :calculate_dates) }

  factory :invoice do
    invoice_number { Faker::Number.number(6) }
    amount { Faker::Commerce.price }
    description { Faker::Lorem.sentence }
    due_date Date.current
    user
    client
  end
end
