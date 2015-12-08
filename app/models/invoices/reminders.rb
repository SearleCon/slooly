module Invoices
  module Reminders
    def self.new(invoice)
      { 'Pre' => PreDue,
        'Due' => Due,
        'OD1' => FirstOverDue,
        'OD2' => SecondOverDue,
        'OD3' => ThirdOverDue,
        'FD' => FinalDemand
      }[invoice.type].new(invoice)
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

      def client
        invoice.client
      end

      def company
        invoice.user.company
      end

      def settings
        invoice.user.setting
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
