module Admins
  class DashboardController < Admins::BaseController
    def index
      @dashboard = Admin::Dashboard.new
    end
  end
end
