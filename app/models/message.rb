class Message

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  
  include ActiveModel::Serialization
  
  attr_accessor :name, :email, :subject, :body

  validates :name, :email, :subject, :body, :presence => true
  validates :email, :format => { :with => %r{.+@.+\..+} }, :allow_blank => true
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end


  def attributes
    {'name'=>name, 'email'=>email, 'subject'=>subject, 'body'=>body}
  end


  def persisted?
    false
  end

end