# == Schema Information
#
# Table name: histories
#
#  id                :integer          primary key
#  date_sent         :date
#  client_id         :integer
#  user_id           :integer
#  subject           :string(255)
#  message           :text
#  reminder_type     :string(255)
#  sent              :boolean
#  email_return_code :string(255)
#  email_sent_from   :string(255)
#  copy_email        :string(255)
#  email_sent_to     :string(255)
#  created_at        :timestamp        not null
#  updated_at        :timestamp        not null
#  invoice_number    :string(255)
#  email_from_name   :string(255)
#

class History < ActiveRecord::Base
  belongs_to :user, inverse_of: :histories
  belongs_to :client, inverse_of: :histories
end
