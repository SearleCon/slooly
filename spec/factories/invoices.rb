# == Schema Information
#
# Table name: invoices
#
#  id             :integer          primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status_id      :integer
#  client_id      :integer
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    invoice_number "MyString"
    due_date "2012-09-04"
    amount "9.99"
    description "MyText"
    status_id 1
    client_id 1
  end
end
