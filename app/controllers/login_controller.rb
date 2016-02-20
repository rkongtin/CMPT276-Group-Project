class LoginController < ApplicationController
  def login
    @user = User.new
  end
  
  #Different Actions
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
end
