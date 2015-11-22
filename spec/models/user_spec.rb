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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  time_zone              :string
#

describe User do

  it 'should have a valid factory' do
    user = build(:user)
    expect(user).to be_valid
  end

 it { should have_many(:clients) }
 it { should have_many(:invoices) }
 it { should have_one(:company) }
 it { should have_one(:setting) }
 it { should have_one(:subscription).conditions(active: true) }


 it { should validate_acceptance_of(:terms_of_service) }

 describe '#timeout_in' do
   it 'should be 2 hours' do
     user = build(:user)
     expect(user.timeout_in).to eq(2.hours)
   end
 end

 describe '#setup' do

   before do
     allow(Plan).to receive(:free_trial).and_return(build(:free_trial))
   end

   it 'should create a company' do
     user = build(:user)
     user.send(:setup)
     expect(user.company).to_not be_nil
   end

   it 'should create settings' do
     user = build(:user)
     user.send(:setup)
     expect(user.setting).to_not be_nil
   end

   it 'should create subscription' do
     user = build(:user)
     user.send(:setup)
     expect(user.subscription).to_not be_nil
   end
 end
end
