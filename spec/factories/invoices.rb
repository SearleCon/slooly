# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  invoice_number :string(255)
#  due_date       :date
#  amount         :decimal(, )
#  description    :text
#  status         :integer          default(2)
#  client_id      :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :integer
#  pd_date        :date
#  od1_date       :date
#  od2_date       :date
#  od3_date       :date
#  last_date_sent :date
#  fd_date        :date
#

FactoryGirl.define do

  factory :invoice do
    invoice_number { Faker::Number.number(6) }
    amount { Faker::Commerce.price }
    description { Faker::Lorem.sentence }
    due_date Date.current
    user
    client

    trait :unsent do
      last_date_sent nil
    end

    trait :non_chasing do
      status [:stop_chasing, :paid, :write_off, :deleted].sample
    end
  end
end
