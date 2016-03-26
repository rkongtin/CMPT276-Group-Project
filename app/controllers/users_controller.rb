class UsersController < ApplicationController
  
  before_action :requireIsAdmin, only: [:index, :edit, :makeAdmin]
    
  def index
    @users = User.all  
  end
  
  def settings
    @user = User.find(params[:id])
    authenticateUser
  end

  #Different Actions
  def show
    @user = User.find(params[:id])
    authenticateUser
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])  
  end
  
  def makeAdmin
    @user = User.find(params[:id])
  end
  
  def changePassword
    @user = User.find(params[:id])
    authenticateUser
  end
  
  def changeEmail
    @user = User.find(params[:id])
    authenticateUser
  end

  #don't have their own view
  def create
    @user = User.new(user_params)
  
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end
  
  
  #all update functions below
  def update
    @user = User.find(params[:id])
  
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def makeAdmin_update
    @user = User.find(params[:id])
    
    if @user.update_attribute(:admin, params[:admin])
      redirect_to @user
    else
      render 'makeAdmin'
    end
  end
  
  def changePassword_update
    @user = User.find(params[:id])
    if @user.update_attributes(params.require(:user).permit(:password, :password_confirmation))
      redirect_to @user
    else
      render 'changePassword'
    end
  end
  
  def changeEmail_update
    @user = User.find(params[:id])
    if @user.update_attribute(:email, params[:email])
      redirect_to @user
    else
      render 'changeEmail'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
    
    #def requireIsAdmin #code to require to be admin, others get redirected back
    #  begin
    #    unless current_user.admin?
    #      redirect_to users_home_path
    #    end
    #  rescue => err  #this will run if user isn't logged in, so current_user.admin? fails, just redirect them to login
    #    redirect_to sessions_new_path
    #  end
    #end
    
    def requireIsAdmin
      if logged_in?
        unless current_user.admin?
          redirect_to users_home_path
        end
      end
    end
    
    def authenticateUser #code to require that proper user is logging in
      if logged_in?
        if current_user.id == @user.id
          #do nothing
        else
          redirect_to current_user  #redirect to profile page if it's not their page
        end
      else
        redirect_to sessions_new_path #if not logged in, redirect to place to log in
      end
    end
      
    
end
