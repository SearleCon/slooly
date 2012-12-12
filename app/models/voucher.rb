class Voucher < ActiveRecord::Base

  attr_accessible :redeemed_by
  attr_readonly :unique_code, :valid_until, :number_of_days
  attr_accessor :prefix, :suffix, :validity_period, :free_days


  before_create :generate_unique_code, :set_valid_until, :set_free_days
  after_update :recalculate_expiry_date


  def self.redeem(voucher_code, user_id)
   voucher = self.find_by_unique_code(voucher_code)
   voucher.redeemed_by = user_id
   voucher.save
  end

  def self.redeemable?(voucher_code)
   # Voucher.exists?(unique_code: voucher_code, redeemed_by: nil)
   voucher = Voucher.find_by_unique_code(voucher_code)
   return false if voucher.nil?
   voucher.valid_until.to_date >= Date.today && voucher.redeemed_by.nil?
  end

  private
  def generate_unique_code
   code = SecureRandom.hex(4)
   code = self.prefix.concat(code)
   code.concat(self.suffix)
   self.unique_code = code
  end

  def set_valid_until
    self.valid_until=Time.now + self.validity_period.months
  end

  def set_free_days
    self.number_of_days = self.free_days
  end
  
  def recalculate_expiry_date
    subscription = Subscription.find_by_user_id(self.redeemed_by)
    subscription.update_attribute(:expiry_date, subscription.expiry_date+self.number_of_days.days)
  end

end

