class SchoolsController < ApplicationController
  
  before_filter :requireIsAdmin #run method requireIsAdmin before allowing them to view pages (checks if admin, if not it redirects them)
  #see   http://stackoverflow.com/questions/5056451/redirect-to-login-page-if-user-not-logged-in

  ########################################
  # Different Actions (pages with views) #
  ########################################
  
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
  
  ##############################
  # all pages without own view #
  ##############################
  
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
  
  #######################################################
  # private functions, not controller actions for pages #
  #######################################################

  private
    def school_params
      params.require(:school).permit(:name, :address, :lat, :long)
    end

    def requireIsAdmin #code to require to be admin, otherwise redirected to home page
      if logged_in?
        unless current_user.admin? #if not admin, redirect to their home path
          redirect_to current_user
        end
      else #if not logged in, redirect to place to log in
        redirect_to sessions_new_path
      end
    end
    
end