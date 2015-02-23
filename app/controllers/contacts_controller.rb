class ContactsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      UserMailer.delay.new_message(@message)
      redirect_to root_url, notice: t('flash.contacts.create')
    else
      render :new
    end
  end
end
