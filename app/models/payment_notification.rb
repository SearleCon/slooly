# == Schema Information
#
# Table name: payment_notifications
#
#  id             :integer          primary key
#  params         :text
#  user_id        :integer
#  status         :string(255)
#  transaction_id :string(255)
#  created_at     :timestamp        not null
#  updated_at     :timestamp        not null
#

class PaymentNotification < ActiveRecord::Base
  serialize :params
  attr_accessible :params, :user_id, :status, :transaction_id

end
