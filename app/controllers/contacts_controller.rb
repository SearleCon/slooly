class ContactsController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      UserMailer.new_message(@message).deliver_now unless @message.spam?
      redirect_to root_url, notice: 'Message was successfully sent.'
    else
      render :new
    end
  end

  private

  def protect_from_spam
    head :ok if params[:message][:content].present?
  end
end
