class SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_settings



  def index;end

  def edit;end

  def update
   flash[:notice] = 'Settings were successfully updated.' if @settings.update_attributes(params[:setting])
   respond_with @settings, location: settings_url
  end


  private
   def set_settings
     @settings = current_user.setting
   end
end
