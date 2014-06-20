class SettingsController < ApplicationController
  before_filter :set_settings

  def index;end

  def edit;end

  def update
   flash[:notice] = 'Settings were successfully updated.' if @settings.update(settings_params)
   respond_with @settings, location: settings_url
  end


  private
   def set_settings
     @settings = current_user.setting
   end

   def settings_params
     params.require(:setting).permit(:days_before_pre_due,
                                     :days_between_chase,
                                     :due_message,
                                     :due_reminder,
                                     :due_subject,
                                     :email_copy_to,
                                     :final_demand_message,
                                     :final_demand_subject,
                                     :overdue1_message,
                                     :overdue1_subject,
                                     :overdue2_message,
                                     :overdue2_subject,
                                     :overdue3_message,
                                     :overdue3_subject,
                                     :payment_method_message,
                                     :pre_due_message,
                                     :pre_due_reminder,
                                     :pre_due_subject,
                                     :send_from_name)
   end
end
