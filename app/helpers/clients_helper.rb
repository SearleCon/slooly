module ClientsHelper
  def contact_and_business_names
    @contact_and_business_names ||= current_user.clients.pluck(:contact_person, :business_name).flatten.sort.reject(&:blank?)
  end
end