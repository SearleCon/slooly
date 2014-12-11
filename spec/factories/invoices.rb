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
  factory :invoice do
    invoice_number { Faker::Number.number(6) }
    amount { Faker::Commerce.price }
    description { Faker::Lorem.sentence }
    due_date Date.today
    user
    client

    trait :pre_due do
      pd_date Date.today
    end

    trait :over_due1 do
      od1_date Date.today
    end

    trait :over_due2 do
      od2_date Date.today
    end

    trait :over_due3 do
      od3_date Date.today
    end

    trait :final_demand do
      fd_date Date.today
      status :send_final_demand
    end

  end
end
