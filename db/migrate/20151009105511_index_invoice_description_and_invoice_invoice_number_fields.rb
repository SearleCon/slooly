class IndexInvoiceDescriptionAndInvoiceInvoiceNumberFields < ActiveRecord::Migration
  def change
    execute "CREATE INDEX description_idx ON invoices USING gist (description gist_trgm_ops);"
    execute "CREATE INDEX invoice_number_idx ON invoices USING gist (invoice_number gist_trgm_ops);"
  end
end
