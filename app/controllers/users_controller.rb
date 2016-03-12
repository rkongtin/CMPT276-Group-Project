class UsersController < ApplicationController
  
  before_action :requireIsAdmin, only: [:index, :edit, :makeAdmin]
    
  def index
    @users = User.all  
  end
  
  def makeAdmin
    @user = User.find(params[:id])
  end
  
  #Different Actions
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])  
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
    if @user.update(params.require(:user).permit(:admin))
      redirect_to @user
    else
      render 'makeAdmin'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
    
    def requireIsAdmin #code to require to be admin, others get redirected back
      begin
        unless current_user.admin?
          redirect_to users_home_path
        end
      rescue => err  #this will run if user isn't logged in, so current_user.admin? fails, just redirect them to login
        redirect_to sessions_new_path
      end
    end
    
end
