module Invoice::Reminders
  def self.new(invoice)
    reminder = nil
    reminder = PreDue.new(invoice) if invoice.pre_due?
    reminder = Due.new(invoice) if invoice.due?
    reminder = FirstOverDue.new(invoice)  if invoice.over_due1?
    reminder = SecondOverDue.new(invoice)  if invoice.over_due2?
    reminder = ThirdOverDue.new(invoice)  if invoice.over_due3?
    reminder = FinalDemand.new(invoice)  if invoice.final_demand?
    reminder
  end

  class Base
    def initialize(invoice)
      @invoice = invoice
    end

    def subject
      fail NotImplementedError
    end

    def message
      fail NotImplementedError
    end

    def text
      %(Attention: #{client.contact_person}\r
      #{client.business_name.gsub(/['"]/, '')}\r
      #{client.address}\r
      #{client.city}\r
      #{client.post_code}\r\n
                      Reference : #{invoice.invoice_number}\r
                      Due Date  : #{invoice.due_date}\r
                      Amount Due: #{invoice.amount}\r\n
      #{message}\r
      #{company.name}\r\n
      #{company.address}\r
      #{company.city}\r
      #{company.post_code}\r
                      Tel  : #{company.telephone}\r
                      Fax  : #{company.fax}\r
                      Email: #{company.email}\r\n
                      Payment Options: \r
      #{setting.payment_method_message}).squish
    end

    def send?
      fail NotImplementedError
    end

    def type
      fail NotImplementedError
    end

    def sender
      company.email
    end

    def sender_name
      setting.send_from_name
    end

    def cc
      setting.email_copy_to
    end

    def recipient
      client.email
    end

    private

    attr_reader :invoice

    def setting
      @setting ||= invoice.user.setting
    end

    def client
      @client ||= invoice.client
    end

    def company
      @company ||= invoice.user.company
    end
  end

  class Due < Base
    def subject
      setting.due_subject
    end

    def message
      setting.due_message
    end

    def type
      'Due'
    end

    def send?
      setting.due_reminder
    end
  end

  class PreDue < Base
    def subject
      setting.pre_due_subject
    end

    def message
      setting.pre_due_message
    end

    def type
      'Pre'
    end

    def send?
      setting.pre_due_reminder
    end
  end

  class FirstOverDue < Base
    def subject
      setting.overdue1_subject
    end

    def message
      setting.overdue1_message
    end

    def type
      'OD1'
    end

    def send?
      true
    end
  end

  class SecondOverDue < Base
    def subject
      setting.overdue2_subject
    end

    def message
      setting.overdue2_message
    end

    def type
      'OD2'
    end

    def send?
      true
    end
  end

  class ThirdOverDue < Base
    def subject
      setting.overdue3_subject
    end

    def message
      setting.overdue3_message
    end

    def type
      'OD3'
    end

    def send?
      true
    end
  end

  class FinalDemand < Base
    def subject
      setting.final_demand_subject
    end

    def message
      setting.final_demand_subject_message
    end

    def type
      'FD'
    end

    def send?
      true
    end
  end
end
