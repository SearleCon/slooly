class Vouchers::Generate
  include Service

  def initialize(*args)
    options = args.extract_options!
    @prefix = options[:prefix]
    @suffix = options[:suffix]
    @valid_for = options[:valid_for]
    @days = options[:days]
  end

  def call
    return if @valid_for.zero? || @days.zero?
    Voucher.create do  |voucher|
      voucher.valid_until = Time.zone.now.advance(months: @valid_for)
      voucher.number_of_days = @days
      voucher.unique_code = generate_unique_code
    end
  end

  private

  def generate_unique_code
    "#{@prefix}#{SecureRandom.hex(4)}#{@suffix}"
  end
end
