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
  puts "Running reminders now..."
  puts "Selecting all invoices with PD, D, OD1, OD2, OD3 or FD dates of TODAY..."
  @invoices = Invoice.all :conditions => ["(pd_date = ? or due_date = ? or od1_date = ? or od2_date = ? or od3_date = ? or fd_date = ?) and (last_date_sent != ?) and (status_id = ? or status_id = ?)", DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, DateTime.now.to_date, 2, 5]
  
  if @invoices.count > 0
    puts "------------------------------------------------"
    puts "Step 1 Start: Invoices found: "+@invoices.count.to_s
    puts "Step 2: Getting Details for Each Invoice..."
    @invoices.each do |invoice|
      puts " "
      puts "==="
      puts " "
      puts "Processing Invoice number: "+invoice.invoice_number+"..."
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


      puts "Completed Processing Invoice number: "+invoice.invoice_number+"..."
#      sleep(1)
    end
    puts "Completed Getting Details for Each Invoice..."
  else
    puts "No Invoices found. Not sending any reminders today. Job Completed!"
  end
  puts "Completed the entire process. "+@invoices.count.to_s+" invoices processed"
  puts "------------------------------------------------"

  puts "Sending Emails"
  
  @to_send = History.all :conditions => ["sent = ?", "f"]
  @to_send.each do |historysend|
    puts "Sending..."    
    #send_to_mandrill(historysend)
    puts historysend.email_sent_from
    puts historysend.email_sent_to
    puts historysend.copy_email

# SHAUN PUT BACK!!!!! JUST REMOVED FOR TESTING AND NO SENDING OF EMAILS!
    UserMailer.delay.send_it(historysend) # working with delayedJob using Mandrill (Don't forget to run: "rake jobs:work" in terminal to process the delayed jobs, or "heroku run rake jobs:work" on production)



    update_sent_flag(historysend)
    puts "Sent!"
    puts "---------"
  end
#  update_all_for_today_as_sent # SS See below
  puts "Sending Emails completed"
  
  
end

def update_last_date_sent(invoice)
  @invoiceupdate = Invoice.first :conditions => ["id = ?", invoice.id]
  @invoiceupdate.last_date_sent = DateTime.now.to_date
  @invoiceupdate.save

#  Invoice.update_all({:status_id => 7}, ["pd_date = ? or due_date = ? or od1_date = ? or od2_date = ? or od3_date = ?", Date.today, Date.today, "2012-10-07", Date.today, Date.today])
  # SS Update all invoices in the main query as already queued and change the main query above to ignore already queued items
  # SS Change the status ID above to the Queued boolean (you must create it)
  # This will stop multiple sendings
  # Maybe have a resend all for today task that ignores this flag, in case we have issues.
end

def update_sent_flag(historysend)
  @historyupdate = History.first :conditions => ["id = ?", historysend.id]
  @historyupdate.sent = "t"
  @historyupdate.save
end

def build_reminder_email(client, company, invoice, setting)
  puts "Building Reminder Email start for Invoice "+invoice.invoice_number+"..."
  puts "Client: "+client.business_name
  puts "Company: "+company.name
  puts "Invoice Number: "+invoice.invoice_number
  puts "Building Reminder Email end for Invoice "+invoice.invoice_number
  puts "\n--- Actual Email Start ---\n\n"  
  @email_message =  ""
  @email_message =  "Attention: \r\n"+client.business_name.gsub(/['"]/, '')+" ("+client.contact_person+")\r\n"
  @email_message += client.address+"\r\n"
  @email_message += client.city+"\r\n"
  @email_message += client.post_code+"\r\n\n"
  
  @email_message += "From: \r\n"+company.name+"\r\n"
  @email_message += company.address+"\r\n"
  @email_message += company.city+"\r\n"
  @email_message += company.post_code+"\r\n"
  @email_message += "Tel  : "+company.telephone+"\r\n"
  @email_message += "Fax  : "+company.fax+"\r\n"
  @email_message += "Email: "+company.email+"\r\n\n"
  
  @email_message += "Reference : "+invoice.invoice_number+"\r\n"
  @email_message += "Due Date  : "+invoice.due_date.to_s+"\r\n"
  @email_message += "Amount Due: "+invoice.amount.to_s+"\r\n\n"
  
  @email_message += fetch_correct_message(invoice)+"\r\n"+company.name+"\r\n\n"   #SS Work out the correct Message to send here
  
  @email_message += "Payment Options: \r\n"+setting.payment_method_message
  
  puts @email_message
  puts "\n--- Actual Email End ---\n"  
  
  save_to_history(@client, @company, invoice, @setting, @email_message)
  update_last_date_sent(invoice) # SS See below
end

def send_to_mandrill(historysend)
#  UserMailer.delay.send_it(historysend) # working with delayedJob using Mandrill (Don't forget to run: "rake jobs:work" in terminal to process the delayed jobs, or "heroku run rake jobs:work" on production)
end

def work_out_reminder_type(invoice)
  if (invoice.pd_date == DateTime.now.to_date)
    @reminder_type = "Pre"
  else
    if (invoice.due_date == DateTime.now.to_date)
      @reminder_type = "Due"
    else
      if (invoice.od1_date == DateTime.now.to_date)
        @reminder_type = "OD1"
      else
        if (invoice.od2_date == DateTime.now.to_date)
          @reminder_type = "OD2"
        else
          if (invoice.od3_date == DateTime.now.to_date)
            @reminder_type = "OD3"
          else
            if (invoice.fd_date == DateTime.now.to_date)
              @reminder_type = "FD"
            else
              @reminder_type = "Unknown"  
            end
          end
        end
      end
    end
  end
end

def fetch_correct_subject_line(invoice)
  if (invoice.pd_date == DateTime.now.to_date)
    @setting.pre_due_subject
  else
    if (invoice.due_date == DateTime.now.to_date)
      @setting.due_subject
    else
      if (invoice.od1_date == DateTime.now.to_date)
          @setting.overdue1_subject
      else
        if (invoice.od2_date == DateTime.now.to_date)
          @setting.overdue2_subject
        else
          if (invoice.od3_date == DateTime.now.to_date)
            @setting.overdue3_subject
          else
            if (invoice.fd_date == DateTime.now.to_date)
              @setting.final_demand_subject
            else
              "ERROR"  
            end
          end
        end
      end
    end
  end
end

def fetch_correct_message(invoice)
  if (invoice.pd_date == DateTime.now.to_date)
    @setting.pre_due_message
  else
    if (invoice.due_date == DateTime.now.to_date)
      @setting.due_message
    else
      if (invoice.od1_date == DateTime.now.to_date)
          @setting.overdue1_message
      else
        if (invoice.od2_date == DateTime.now.to_date)
          @setting.overdue2_message
        else
          if (invoice.od3_date == DateTime.now.to_date)
            @setting.overdue3_message
          else
            if (invoice.fd_date == DateTime.now.to_date)
              @setting.final_demand_message
            else
              "ERROR - If you received this email, something has gone wrong. Please contact the sender listed above, or simply ignore it."  
            end
          end
        end
      end
    end
  end
end


def save_to_history(client, company, invoice, setting, actual_email_message)
  @history = History.new
  
  @history.invoice_number     = invoice.invoice_number
	@history.date_sent          = DateTime.now
  @history.client_id          = client.id
  @history.subject            = fetch_correct_subject_line(invoice)
  @history.message            = actual_email_message
  @history.reminder_type      = work_out_reminder_type(invoice)
  @history.sent               = "f" # Will be false and changed as soon as sent to Mandrill
  @history.email_return_code  = "Not yet sent" # Change on send of Mandrill - This is actually similar to the above flag, but can be used to save return codes from Mandrill instead
  @history.email_sent_from    = company.email
  @history.copy_email         = setting.email_copy_to
  @history.email_sent_to	    = client.email # "shaun.searle@gmail.com" # SS Change this back! to client.email
  @history.user_id            = client.user_id
  @history.email_from_name    = setting.send_from_name
  	
	@history.save
end