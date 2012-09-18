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


task :send_reminders => :environment do
  puts "Running reminders now..."
  puts "Selecting all invoices with PD, D, OD1, OD2 or OD3 dates of TODAY..."
  @invoices = Invoice.all :conditions => ["pd_date = ? or due_date = ? or od1_date = ? or od2_date = ? or od3_date = ?", Date.today, Date.today, "2012-10-07", Date.today, Date.today]
  
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
      build_reminder_email(@client, @company, invoice, @setting)
      puts "Completed Processing Invoice number: "+invoice.invoice_number+"..."
#      sleep(1)
    end
    puts "Completed Getting Details for Each Invoice..."
  else
    puts "No Invoices found. Not sending any reminders today. Job Completed!"
  end
  puts "Completed the entire process. "+@invoices.count.to_s+" invoices successfully processed"
  puts "------------------------------------------------"

  puts "Sending Emails"
  
  @to_send = History.all :conditions => ["sent = ?", "f"]
  @to_send.each do |historysend|
    puts "Sending..."    
    #send_to_mandrill(historysend)
    UserMailer.delay.send_it(historysend) # working with delayedJob using Mandrill (Don't forget to run: "rake jobs:work" in terminal to process the delayed jobs, or "heroku run rake jobs:work" on production)
    update_sent_flag(historysend)
    puts "Sent!"
    puts "---------"
  end
  update_all_for_today_as_queued # SS See below
  puts "Sending Emails completed"
  
  
end

def update_all_for_today_as_queued
  Invoice.update_all({:status_id => 7}, ["pd_date = ? or due_date = ? or od1_date = ? or od2_date = ? or od3_date = ?", Date.today, Date.today, "2012-10-07", Date.today, Date.today])
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
  @email_message =  "Attention: \n"+client.business_name+" ("+client.contact_person+")\n"
  @email_message += client.address+"\n"
  @email_message += client.city+"\n"
  @email_message += client.post_code+"\n\n"
  
  @email_message += "From: \n"+company.name+"\n"
  @email_message += company.address+"\n"
  @email_message += company.city+"\n"
  @email_message += company.post_code+"\n"
  @email_message += "Tel  : "+company.telephone+"\n"
  @email_message += "Fax  : "+company.fax+"\n"
  @email_message += "Email: "+company.email+"\n\n"
  
  @email_message += "Reference : "+invoice.invoice_number+"\n"
  @email_message += "Due Date  : "+invoice.due_date.to_s+"\n"
  @email_message += "Amount Due: "+invoice.amount.to_s+"\n\n"
  
  @email_message += setting.pre_due_message+"\n"+company.name+"\n\n"  
  
  @email_message += "Payment Options: \n"+setting.payment_method_message
  
  puts @email_message
  puts "\n--- Actual Email End ---\n"  
  
  save_to_history(@client, @company, invoice, @setting, @email_message)
end

def send_to_mandrill(historysend)
#  UserMailer.delay.send_it(historysend) # working with delayedJob using Mandrill (Don't forget to run: "rake jobs:work" in terminal to process the delayed jobs, or "heroku run rake jobs:work" on production)
end

def save_to_history(client, company, invoice, setting, actual_email_message)
  @history = History.new
  
  @history.invoice_number     = invoice.invoice_number
	@history.date_sent          = DateTime.now
  @history.client_id          = client.id
  @history.subject            = "Get the Correct Subject"
  @history.message            = actual_email_message
  @history.reminder_type      = "Get the correct reminder Type"
  @history.sent               = "f" # Will be false and changed as soon as sent to Mandrill
  @history.email_return_code  = "Not yet sent" # Change on send of Mandrill
  @history.email_sent_from    = setting.send_from_name
  @history.copy_email         = setting.email_copy_to
  @history.email_sent_to	    = "shaun.searle@gmail.com" # SS Change this back! to client.email
  @history.user_id            = client.user_id
  	
	@history.save
end