module Admins
  class DashboardController < Admins::BaseController
    def index
      @dashboard = Admins::Dashboard.new
    end
  end
end
