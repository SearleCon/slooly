class Plan < ActiveRecord::Base
  attr_accessible :active, :cost, :description, :duration  
  has_many :subscriptions
  
end
