# == Schema Information
#
# Table name: plans
#
#  id          :integer          not null, primary key
#  description :string(255)
#  duration    :integer
#  cost        :decimal(, )
#  active      :boolean
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  free        :boolean
#

class PlansController < ApplicationController
  before_action :authenticate_user!

  def index
    @plans = Plan.available
  end
end
