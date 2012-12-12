class ContactController < ApplicationController
  
  def new
      @message = Message.new
    end

    def create
      @message = Message.new(params[:message])

      if @message.valid?
#        UserMailer.delay.new_message(@message) # SS You removed this due to it not working on Delayed Job - Syck error. You added the next line instead so it doesnt use DelayedJob
        
        UserMailer.new_message(@message).deliver
        redirect_to(root_path, :notice => "Message was successfully sent.")
      else
        flash.now.alert = "Please fill all fields."
        render :new
      end
    end
    
end