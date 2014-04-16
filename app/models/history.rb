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
  attr_accessible :client_id, :copy_email, :date_sent, :email_return_code, :email_sent_from, :email_sent_to, :message, :reminder_type, :sent, :subject, :user_id
  belongs_to      :user

  def self.by_user(user)
    where("user_id = ?", user)    
  end

  def self.for_client(client_id) 
      where("client_id = ?", client_id)
  end


end
