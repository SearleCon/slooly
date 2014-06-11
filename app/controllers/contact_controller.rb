class ContactController < ApplicationController
  
    def new
      @message = Message.new
    end

    def create
        @message = Message.new(params[:message])
        if @message.valid?
          UserMailer.new_message(@message).deliver
          redirect_to root_url, notice: "Message was successfully sent."
        else
          render :new
        end
    end
end