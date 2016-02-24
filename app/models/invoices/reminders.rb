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
        raise NotImplementedError
      end

      def message
        raise NotImplementedError
      end

      def payment_method_message
        user.payment_method_message
      end

      def type
        invoice.type
      end

      def sender
        company.email
      end

      def sender_name
        user.reminder_email_sender_address
      end

      def cc
        user.reminder_email_cc_address
      end

      def recipient
        client.email
      end

      delegate :client, to: :invoice

      def company
        invoice.user.company
      end

      def user
        invoice.user
      end
    end

    class Due < Base
      def subject
        user.due_reminder_email_subject
      end

      def message
        user.due_reminder_email_message
      end
    end

    class PreDue < Base
      def subject
        user.pre_due_reminder_email_subject
      end

      def message
        user.pre_due_reminder_email_message
      end
    end

    class FirstOverDue < Base
      def subject
        user.first_overdue_reminder_email_subject
      end

      def message
        user.first_overdue_reminder_email_message
      end
    end

    class SecondOverDue < Base
      def subject
        user.second_overdue_reminder_email_subject
      end

      def message
        user.second_overdue_reminder_email_message
      end
    end

    class ThirdOverDue < Base
      def subject
        user.third_overdue_reminder_email_subject
      end

      def message
        user.third_overdue_reminder_email_message
      end
    end

    class FinalDemand < Base
      def subject
        user.final_demand_reminder_email_subject
      end

      def message
        user.final_demand_reminder_email_message
      end
    end
  end
end
