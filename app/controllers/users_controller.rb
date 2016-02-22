class UsersController < ApplicationController
    
  def index
    @user = User.all  
  end
  

  #Different Actions
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end
