class WelcomeController < ApplicationController
  before_action :authenticate_user!, :authorize_user!
end
