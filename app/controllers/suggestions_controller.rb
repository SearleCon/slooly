# == Schema Information
#
# Table name: suggestions
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  comment    :text
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SuggestionsController < ApplicationController
  def new
    @suggestion = Suggestion.new
  end

  def create
    @suggestion = Suggestion.create(suggestion_params)
    respond_with @suggestion, location: root_url
  end

  private

  def suggestion_params
    params.fetch(:suggestion).permit(:comment, :email, :subject)
  end
end
