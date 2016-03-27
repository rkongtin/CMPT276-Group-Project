class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase) #find user by email
    if user && user.authenticate(params[:session][:password]) #if user properly authenticated, log them in and redirect to their home page
      log_in user
      redirect_to home_user_path(current_user)
    else #if fail to log in, display error and render login page again with the error
      flash.now[:danger] = 'Invalid email/password. Please try again.'
      render 'new'
    end
  end
  
  def destroy #destroy current session, so log out and then redirect user to defualt home page
    log_out
    redirect_to root_url
  end
end
