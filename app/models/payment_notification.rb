# == Schema Information
#
# Table name: payment_notifications
#
#  id             :integer          not null, primary key
#  params         :text
#  user_id        :integer
#  status         :string(255)
#  transaction_id :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class PaymentNotification < ActiveRecord::Base
  serialize :params
end
