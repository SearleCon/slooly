class User < ActiveRecord::Base
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
  
# SS Added for Welcome email
  after_create :send_welcome_email 
  
  private
  
    def send_welcome_email
      UserMailer.registration_confirmation(@user).deliver
    end

end