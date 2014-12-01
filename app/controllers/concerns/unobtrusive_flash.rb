module UnobtrusiveFlash
  extend ActiveSupport::Concern

  included do
    after_action :add_flash_to_cookie
  end

  private

  def add_flash_to_cookie
    if flash.any?
      messages = flash.to_hash.merge(flash.now.flash.to_hash).select { |_, v| v.present? }
      cookies[:flash_messages] = { value: JSON.generate(messages), domain: set_cookie_domain }
      flash.clear
    end
  end

  def set_cookie_domain
    (request.host =~ /\.herokuapp\.com$/) ? request.host : :all
  end
end
