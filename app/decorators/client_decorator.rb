class ClientDecorator < Draper::Decorator
  delegate_all

  decorates_association :invoices, scope: :chasing
  decorates_association :histories

  def business_name
    model.business_name.titleize
  end

  def contact_person
    model.contact_person.titleize if model.contact_person.present?
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
