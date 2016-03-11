class SchoolsController < ApplicationController
  
  before_filter :requireIsAdmin #require them to be admin to view these pages, otherwise redirect them. Code is run right away
  #see   http://stackoverflow.com/questions/5056451/redirect-to-login-page-if-user-not-logged-in

  def index
    @schools = School.all
  end

  def new
    @school = School.new
  end

  def show
    @school = School.find(params[:id])
  end

  def edit
    @school = School.find(params[:id])
  end
  
  def create
    @school = School.new(school_params)
  
    if @school.save
      redirect_to @school
    else
      render 'new'
    end
  end
  
  def update
    @school = School.find(params[:id])
  
    if @school.update(school_params)
      redirect_to @school
    else
      render 'edit'
    end
  end
  
  def destroy
    @school = School.find(params[:id])
    @school.destroy
  
    redirect_to schools_path
  end

  private
    def school_params
      params.require(:school).permit(:name, :address, :lat, :long)
    end



    def requireIsAdmin #code to require to be admin, others get redirected back
      begin
        unless current_user.admin?
          redirect_to users_home_path
        end
      rescue nil  #this will run if user isn't logged in, so current_user.admin? fails, just redirect them to login
        redirect_to sessions_new_path
      end
    end

end
