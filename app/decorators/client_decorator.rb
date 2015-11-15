class ClientDecorator < Decorators::BaseDecorator

def histories
    @invoices ||= HistoriesDecorator.decorate(histories, h)
  end


  def invoices
   @invoices ||= InvoicesDecorator.decorate(invoices.chasing, h)
  end

  def business_name
    model.business_name.titleize
  end

  def contact_person
    model.contact_person.try(:titleize)
  end

  def telephone
    h.number_to_phone(model.telephone, area_code: true)
  end

  def fax
    h.number_to_phone(model.fax, area_code: true)
  end

  def email
    h.obfuscate_email model.email if model.email.present?
  end
end
