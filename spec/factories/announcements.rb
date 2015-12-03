# == Schema Information
#
# Table name: announcements
#
#  id          :integer          not null, primary key
#  headline    :string(255)
#  description :text
#  posted_by   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :announcement do
    headline { Faker::Lorem.sentence(3) }
    description { Faker::Lorem.paragraph }
    posted_by { Faker::Name.name }
  end
end
