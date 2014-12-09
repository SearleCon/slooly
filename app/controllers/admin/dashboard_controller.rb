class Admin::DashboardController < ApplicationController
  def index
    all_users = User.all
    users = all_users.paginate(page: params[:page], per_page: 5).order('created_at DESC')
    new_users = all_users.where('created_at >= ?', DateTime.yesterday)
    histories =  History.order('created_at desc')
    suggestions = Suggestion.all
    jobs = Delayed::Job.all
    @administration_data = AdministrationData.new(users, new_users, histories, suggestions, jobs)
  end
end
