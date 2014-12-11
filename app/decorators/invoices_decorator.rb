class InvoicesDecorator < Draper::CollectionDecorator
  delegate :current_page, :per_page, :offset, :total_entries, :total_pages

  delegate :total, to: :object
end
