class UsersController < ApplicationController
  
  #for below, please see the specific methods to see where redirections go
  
  #pages here require user to be admin to access
  before_action :requireIsAdmin, only: [:index, :edit, :makeAdmin]
  
  #authenticate the correct user for these pages
  #also, it will call @user = User.find(params[:id]), so @user is the variable for the user whose page that is
  before_action :authenticateUser, only: [:settings, :show, :changePassword, :changeEmail, :home, :map, :changePassword_update, :changeEmail_update]
    
  
  ########################################
  # Different Actions (pages with views) #
  ########################################
  
  def index
    @users = User.all  
  end
  
  def settings #the settings page, can find links to change password and email here
  end
  
  def show #this is the used as the profile info page, used to show email and name right now
  end
  
  def new #create new user
    @user = User.new
  end
  
  def makeAdmin
    @user = User.find(params[:id])
  end
  
  def home
    @user = User.find(params[:id])
  end
  
  def map
    @houses = House.all
  end
  
  def changePassword #page to change password
  end
  
  def changeEmail #page to change email
  end
  
  ##############################
  # all pages without own view #
  ##############################
  
  def create
    @user = User.new(user_params)
  
    if @user.save
      log_in @user #automatically log in user, then redirect them to their profile page
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def update #this would be used with a regular update page, not currently in use and it updates everything then
    @user = User.find(params[:id])
  
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def makeAdmin_update #update function to change admin field (only changes admin val)
    @user = User.find(params[:id])
    
    if @user.update_attribute(:admin, params[:admin])
      redirect_to @user
    else
      render 'makeAdmin'
    end
  end
  
  def changePassword_update #update function for changing password (only changes password)
    @user = User.find(params[:id])
    if @user.update_attributes(params.require(:user).permit(:password, :password_confirmation)) #confirm :password and :password_confirmation are same, then update the :password_digest field to hashed val
      redirect_to @user #redirect to profile page after (the show page)
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
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
  
    redirect_to users_path
  end

  #######################################################
  # private functions, not controller actions for pages #
  #######################################################
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
    
    def requireIsAdmin #code to require to be admin, otherwise redirected to profile page
      if logged_in?
        unless current_user.admin? #if not admin, redirect to their profile page
          redirect_to current_user
        end
      else #if not logged in, redirect to place to log in
        redirect_to sessions_new_path
      end
    end

    def authenticateUser #code to require that proper user is logging in
      if logged_in?
        @user = User.find(params[:id]) #find who's page this is (by their id)
        unless current_user.id == @user.id #if trying to access page that isn't their own (example, not their own home page)
          redirect_to current_user
        end
      else #if not logged in, redirect to place to log in
        redirect_to sessions_new_path
      end
    end
    
end
