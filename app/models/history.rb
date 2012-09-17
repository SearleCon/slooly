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
