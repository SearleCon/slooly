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

task send_reminders: :environment do
  @invoices = InvoicesToSend.new.invoices
  @invoices.each do |invoice|

    @client = invoice.client
    @company = invoice.user.company
    @setting = invoice.user.setting

    next if (invoice.pre_due? && !@setting.pre_due_reminder) || (invoice.due? && !@setting.due_reminder)

    email_message = %(Attention: #{@client.contact_person}\r
                      #{@client.business_name.gsub(/['"]/, '')}\r
                      #{@client.address}\r
                      #{@client.city}\r
                      #{@client.post_code}\r\n
                      Reference : #{invoice.invoice_number}\r
                      Due Date  : #{invoice.due_date}\r
                      Amount Due: #{invoice.amount}\r\n
                      #{fetch_correct_message(invoice)}\r
                      #{@company.name}\r\n
                      #{@company.address}\r
                      #{@company.city}\r
                      #{@company.post_code}\r
                      Tel  : #{@company.telephone}\r
                      Fax  : #{@company.fax}\r
                      Email: #{@company.email}\r\n
                      Payment Options: \r
                      #{@setting.payment_method_message}).squish

    history = create_history(@client, invoice, @company, @setting, email_message)
    UserMailer.delay.send_it(history)
    history.update(sent: true)
    invoice.update(last_date_sent: Date.today)
  end
  puts "Sending Invoices #{@invoices.size} complete"
end

def reminder_type_for(invoice)
  reminder_type = 'Unknown'
  reminder_type = 'Pre' if invoice.pre_due?
  reminder_type = 'Due' if invoice.due?
  reminder_type = 'OD1' if invoice.over_due1?
  reminder_type = 'OD2' if invoice.over_due2?
  reminder_type = 'OD3' if invoice.over_due3?
  reminder_type = 'FD' if  invoice.final_demand?
  reminder_type
end

def fetch_correct_subject_line(invoice)
  subject = 'ERROR'
  subject = @setting.pre_due_subject if invoice.pre_due?
  subject = @setting.due_subject if invoice.due?
  subject = @setting.overdue1_subject if invoice.over_due1?
  subject = @setting.overdue2_subject if invoice.over_due2?
  subject = @setting.overdue3_subject if invoice.over_due3?
  subject = @setting.final_demand_subject if invoice.final_demand?
  subject
end

def fetch_correct_message(invoice)
  message = 'ERROR - If you received this email, something has gone wrong. Please contact the sender listed above, or simply ignore it.'
  message = @setting.pre_due_message if invoice.pre_due?
  message = @setting.due_message if invoice.due?
  message = @setting.overdue1_message if invoice.over_due1?
  message = @setting.overdue2_message if invoice.over_due2?
  message = @setting.overdue3_message if invoice.over_due3?
  message = @setting.final_demand_message if invoice.final_demand?
  message
end

def create_history(client, invoice, company, setting, email_message)
  client.histories.create do |history|
    history.invoice_number = invoice.invoice_number
    history.subject = fetch_correct_subject_line(invoice)
    history.message = email_message
    history.reminder_type = reminder_type_for(invoice)
    history.email_sent_from = company.email
    history.copy_email = setting.email_copy_to
    history.email_sent_to = client.email
    history.user = invoice.user
    history.email_from_name = setting.send_from_name
  end
end
