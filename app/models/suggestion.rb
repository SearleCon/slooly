class Suggestion < ActiveRecord::Base
  attr_accessible :comment, :email, :subject
end
