  class GenerateVoucher
    def initialize(*args)
      options = args.extract_options!
      @prefix = options[:prefix]
      @suffix = options[:suffix]
      @valid_for = options.fetch(:valid_for, 1)
      @days = options.fetch(:days, 30)
    end

    def self.generate(*args)
      new(*args).generate
    end

    def generate
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
