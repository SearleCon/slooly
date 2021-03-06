class Message
  include ActiveModel::Model

  attr_accessor :name, :email, :subject, :body, :content

  validates :name, :email, :subject, :body, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  def spam?
    content.present?
  end
end
