class User < ActiveRecord::Base  
  cattr_accessor :current_user
  
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  has_many        :clients, :dependent => :destroy
  has_one         :company, :dependent => :destroy
  has_one         :setting, :dependent => :destroy
  
# SS Added for Welcome email WAS HERE WORKING
  after_create :send_welcome_email
  
  private
  
    def send_welcome_email #SS These are the changes to the Delayed Job!
# WORKING      UserMailer.registration_confirmation(self).deliver
      UserMailer.delay.registration_confirmation(self)
    end
    handle_asynchronously :send_welcome_email, :run_at => Proc.new { 2.seconds.from_now }

end