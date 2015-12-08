module Invoices
  module Reminders
    def self.new(invoice)
      { 'Pre' => PreDue,
        'Due' => Due,
        'OD1' => FirstOverDue,
        'OD2' => SecondOverDue,
        'OD3' => ThirdOverDue,
        'FD' => FinalDemand }[invoice.type].new(invoice)
    end

    class Base
      attr_reader :invoice

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
        %(
          Attention: #{client.contact_person}\r
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
          #{settings.payment_method_message}
        )
      end

      def send?
        fail NotImplementedError
      end

      def type
        @invoice.type
      end

      def sender
        company.email
      end

      def sender_name
        settings.send_from_name
      end

      def cc
        settings.email_copy_to
      end

      def recipient
        client.email
      end

      private

      def settings
        @settings ||= invoice.user.setting
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
        settings.due_subject
      end

      def message
        settings.due_message
      end

      def send?
        settings.due_reminder
      end
    end

    class PreDue < Base
      def subject
        settings.pre_due_subject
      end

      def message
        settings.pre_due_message
      end

      def send?
        settings.pre_due_reminder
      end
    end

    class FirstOverDue < Base
      def subject
        settings.overdue1_subject
      end

      def message
        settings.overdue1_message
      end

      def send?
        true
      end
    end

    class SecondOverDue < Base
      def subject
        settings.overdue2_subject
      end

      def message
        settings.overdue2_message
      end

      def send?
        true
      end
    end

    class ThirdOverDue < Base
      def subject
        settings.overdue3_subject
      end

      def message
        settings.overdue3_message
      end

      def send?
        true
      end
    end

    class FinalDemand < Base
      def subject
        settings.final_demand_subject
      end

      def message
        settings.final_demand_message
      end

      def send?
        true
      end
    end
  end
end