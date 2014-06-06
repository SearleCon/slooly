class ContactController < ApplicationController
  
    def new
      @message = Message.new
    end

    def create
        @message = Message.new(params[:message])
        if @message.valid?
          unless params[:content].present?
            UserMailer.new_message(@message).deliver
            flash[:notice] = "Message was successfully sent."
          end
          redirect_to root_url
        else
          render :new
        end
    end
end