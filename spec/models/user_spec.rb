# == Schema Information
#
# Table name: users
#
#  id                     :integer          primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :timestamp
#  remember_created_at    :timestamp
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :timestamp
#  last_sign_in_at        :timestamp
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :timestamp        not null
#  updated_at             :timestamp        not null
#  name                   :string(255)
#

describe User do
 it 'should have a valid factory' do
  user = build(:user)
  expect(user).to be_valid
 end

 it { should have_many(:clients).dependent(:destroy) }
 it { should have_many(:invoices).dependent(:destroy) }
 it { should have_many(:subscriptions).dependent(:destroy) }
 it { should have_many(:histories).dependent(:destroy) }
 it { should have_one(:company).dependent(:destroy) }
 it { should have_one(:setting).dependent(:destroy) }

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
     expect(user.current_subscription).to_not be_nil
   end
 end
end
