module UnobtrusiveFlash
  extend ActiveSupport::Concern

  included do
    after_action :add_flash_to_cookie
  end

  private

  def add_flash_to_cookie
    if flash.any?
      cookies[:flash_messages] = { value: JSON.generate(messages_from_flash), domain: set_cookie_domain }
      flash.clear
    end
  end

  def messages_from_flash
    flash.to_hash.merge(flash.now.flash.to_hash).select { |_k, v| v.present? }
  end

  def set_cookie_domain
    (request.host =~ /\.herokuapp\.com$/) ? request.host : :all
  end
end
