# SHAUN! This is where you put in details for running of background tasks
# Run these methods in the background by typing this in the terminal: "rake send_reminders" (it will then run the second task in this file reminder!)
# Any files stores in the LIB folder can be called.
# And the same files can be run in Heroku by calling: "heroku run rake send_reminders"
# You can use the Heroku Scheduler add on to run these kind of jobs automatically, daily, hourly or every 10 minutes (They count towards your dyno hours though!)
# Check out https://devcenter.heroku.com/articles/scheduler for more information on scheduling
# rake tasks:run
# rake jobs:work


# SS NOTE:
# These are the three things that need to run in order to get the emails sending:
# 1. "rake send_reminders" - This is your rake task in the actual rake file (lib directory - i.e. THIS file (See the task below))
# 2. "rake jobs:work" - On heroku can be run too. Needs to be running to process delayed jobs
# 3. Your server must be running

task :resend_todays_reminders => :environment do # This task ignores the last_date_send in the main query, thereby resending all the emails for today
    @invoices = Invoice.all :conditions => ["(pd_date = ? or due_date = ? or od1_date = ? or od2_date = ? or od3_date = ? or fd_date = ?)  and (status_id = ? or status_id = ?)", DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date]

    if @invoices.count > 0
      @invoices.each do |invoice|
        @client = Client.first :conditions => ["id = ?", invoice.client_id]
        @company = Company.first :conditions => ["user_id = ?", invoice.user_id]
        @setting = Setting.first :conditions => ["user_id = ?", invoice.user_id]


        if (((invoice.pd_date == Date.today) && (@setting.pre_due_reminder == false)) || ((invoice.due_date == Date.today) && (@setting.due_reminder == false)))
          puts "Skipping this invoice, as it has either the Pre_Due boolean or the Due boolean set to false (i.e. DONT SEND for this User!)"
          puts "predue date: "+invoice.pd_date.to_s
          puts "predue set: "+@setting.pre_due_reminder.to_s
          puts "due date: "+invoice.due_date.to_s
          puts "due set: "+@setting.due_reminder.to_s

        else
          build_reminder_email(@client, @company, invoice, @setting)
        end


#        build_reminder_email(@client, @company, invoice, @setting)
      end
    else
    end
    puts "Completed the entire process. "+@invoices.count.to_s+" invoices processed"
    @to_send = History.all :conditions => ["sent = ?", "f"]
    @to_send.each do |historysend|

      UserMailer.delay.send_it(historysend) # working with delayedJob using Mandrill (Don't forget to run: "rake jobs:work" in terminal to process the delayed jobs, or "heroku run rake jobs:work" on production)

      update_sent_flag(historysend)
    end
    puts "Sending Emails completed"
end  

task :send_reminders => :environment do
  @invoices = Invoice.where("(last_date_sent != :today) and (pd_date = :today or due_date = :today or od1_date = :today or od2_date = :today or od3_date = :today or fd_date = :today) and  (status_id = :chasing or status_id = :send_final_demand)", today: DateTime.now.to_date,chasing: 2, send_final_demand: 5)
    @invoices.each do |invoice|
      puts 'Sending Invoices'

      @client = invoice.client
      @company = invoice.user.company
      @setting = invoice.user.setting

      unless (invoice.pd_date == Date.today && @setting.pre_due_reminder == false) || (invoice.due_date == Date.today && @setting.due_reminder == false)
        email_message =  "Attention: "+ @client.contact_person+"\r\n"
        email_message += @client.business_name.gsub(/['"]/, '')+"\r\n"
        email_message += @client.address+"\r\n"
        email_message += @client.city+"\r\n"
        email_message += @client.post_code+"\r\n\n"

        email_message += "Reference : "+invoice.invoice_number+"\r\n"
        email_message += "Due Date  : "+invoice.due_date.to_s+"\r\n"
        email_message += "Amount Due: "+invoice.amount.to_s+"\r\n\n"

        email_message += fetch_correct_message(invoice)+"\r\n"+@company.name+"\r\n\n"
        email_message += @company.address+"\r\n"
        email_message += @company.city+"\r\n"
        email_message += @company.post_code+"\r\n"
        email_message += "Tel  : "+@company.telephone+"\r\n"
        email_message += "Fax  : "+@company.fax+"\r\n"
        email_message += "Email: "+@company.email+"\r\n\n"

        email_message += "Payment Options: \r\n"+ @setting.payment_method_message

        history = create_history(invoice, @setting, email_message )
       # UserMailer.delay.send_it(history)
        history.update_attributes(sent: true)
        invoice.update_attributes(last_date_sent: Date.today)
      end
      puts "Sending Invoices #{@invoices.size} complete"
    end
end

def work_out_reminder_type(invoice)
  reminder_type = "Unknown"
  reminder_type = "Pre" if invoice.pd_date == DateTime.now.to_date
  reminder_type = "Due" if invoice.due_date == DateTime.now.to_date
  reminder_type = "OD1" if invoice.od1_date == DateTime.now.to_date
  reminder_type = "OD2" if invoice.od2_date == DateTime.now.to_date
  reminder_type = "OD3" if invoice.od3_date == DateTime.now.to_date
  reminder_type = "FD" if invoice.fd_date == DateTime.now.to_date
  reminder_type
end

def fetch_correct_subject_line(invoice)
  subject = "ERROR"
  subject = @setting.pre_due_subject if invoice.pd_date == DateTime.now.to_date
  subject = @setting.due_subject if invoice.due_date == DateTime.now.to_date
  subject = @setting.overdue1_subject if invoice.od1_date == DateTime.now.to_date
  subject = @setting.overdue2_subject if invoice.od2_date == DateTime.now.to_date
  subject = @setting.overdue3_subject if invoice.od3_date == DateTime.now.to_date
  subject = @setting.final_demand_subject if invoice.fd_date == DateTime.now.to_date
  subject
end

def fetch_correct_message(invoice)
  message = "ERROR - If you received this email, something has gone wrong. Please contact the sender listed above, or simply ignore it."
  message = @setting.pre_due_message if invoice.pd_date == DateTime.now.to_date
  message = @setting.due_message if invoice.due_date == DateTime.now.to_date
  message = @setting.overdue1_message if invoice.od1_date == DateTime.now.to_date
  message = @setting.overdue2_message if invoice.od2_date == DateTime.now.to_date
  message = @setting.overdue3_message if invoice.od3_date == DateTime.now.to_date
  message = @setting.final_demand_message if invoice.fd_date == DateTime.now.to_date
  message
end


def create_history(invoice, setting, actual_email_message)
  History.create do  |history|
    history.invoice_number     = invoice.invoice_number
    history.date_sent          = DateTime.now
    history.client_id          = invoice.client_id
    history.subject            = fetch_correct_subject_line(invoice)
    history.message            = actual_email_message
    history.reminder_type      = work_out_reminder_type(invoice)
    history.sent               = false
    history.email_return_code  = "Not yet sent"
    history.email_sent_from    = invoice.user.company.email
    history.copy_email         = setting.email_copy_to
    history.email_sent_to	    = invoice.client.email
    history.user_id            = invoice.user_id
    history.email_from_name    = setting.send_from_name
  end
end


