class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end


  # def create
  #   @user = User.new(params[:user])
  # 
  #   respond_to do |format|
  #     if @user.save
  #       UserMailer.registration_confirmation(@user).deliver
  #       format.html { redirect_to(@user, :notice => 'User was successfully created.') }
  #       format.xml  { render :xml => @user, :status => :created, :location => @user }
  #     else
  #       format.html { render :action => "new" }
  #       format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
  #     end
  #   end
  # end
  
end