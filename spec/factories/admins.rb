# == Schema Information
#
# Table name: admins
#
#  id                  :integer          not null, primary key
#  email               :string           default(""), not null
#  encrypted_password  :string           default(""), not null
#  remember_created_at :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

FactoryGirl.define do
  factory :admin do
    
  end

end
