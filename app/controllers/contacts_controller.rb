class ContactsController < ApplicationController

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      UserMailer.delay.new_message(@message)
      redirect_to root_url, notice: 'Message was successfully sent.'
    else
      render :new
    end
  end
end
