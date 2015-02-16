# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  role                   :integer          default(0)
#  time_zone              :string(255)
#

describe User do
 it 'should have a valid factory' do
  user = build(:user)
  expect(user).to be_valid
 end

 it { should have_many(:clients) }
 it { should have_many(:invoices) }
 it { should have_many(:subscriptions) }
 it { should have_many(:histories) }
 it { should have_one(:company) }
 it { should have_one(:setting) }

 it { should validate_acceptance_of(:terms_of_service) }

 describe '#timeout_in' do
   it 'should be 2 hours' do
     user = build(:user)
     expect(user.timeout_in).to eq(2.hours)
   end
 end

 describe '#current_subscription' do
   it 'should return the current active subscription for a user' do
     user = create(:subscribed_user)
     expect(user.subscription).to_not be_nil
   end
 end
end
