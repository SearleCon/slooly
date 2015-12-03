module Invoice
  class Age
    include Comparable

    def self.from_due_date(due_date)
      new((Date.current - due_date.to_date).to_i)
    end

    def initialize(age)
      @age = age
    end

    def <=>(other)
      other <=> @age
    end

    def current?
      @age.zero?
    end

    def due?
      @age > 0
    end

    def overdue?
      @age < 0
    end

    def to_s
      @age.to_s
    end
  end
end
