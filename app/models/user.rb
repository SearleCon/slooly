class User < ActiveRecord::Base  
  cattr_accessor :current_user
#  validates :terms_of_service, :acceptance => true
  
  
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :terms_of_service
  
  has_many        :clients, :dependent => :destroy
  has_one         :company, :dependent => :destroy
  has_one         :setting, :dependent => :destroy
  validates :terms_of_service, :acceptance => true
  
# SS Added for Welcome email WAS HERE WORKING
  after_create :send_welcome_email
  
  def reload(options = nil)
     super
     @subscription = nil
   end
  
  def active_subscription
    @subscription ||= Subscription.find_by_user_id_and_active(self, true)
  end
  
  
  private
  
    def send_welcome_email #SS These are the changes to the Delayed Job!
 #     UserMailer.registration_confirmation(self).deliver # WORKING without delayed-job, but slow (user must wait)
      UserMailer.delay.registration_confirmation(self) # working with delayedJob using Mandrill (Don't forget to run: "rake jobs:work" in terminal to process the delayed jobs, or "heroku run rake jobs:work" on production)
    end
    handle_asynchronously :send_welcome_email, :run_at => Proc.new { 2.seconds.from_now }

end