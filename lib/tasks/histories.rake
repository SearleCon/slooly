namespace :histories do
  desc 'Update invoice ids from invoice number'
  task update_invoice_ids: :environment do
    History.transaction do
      History.find_each do |history|
          history.invoice = Invoice.find_by(invoice_number: history.invoice_number)
          history.save!
          puts "#{history.id} updated"
      end
    end
  end
end
