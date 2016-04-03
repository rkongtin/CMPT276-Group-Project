class HousesController < ApplicationController
  
  #code mostly copied from schools_controller
  
  before_filter :requireIsAdmin, except: [:info] #run method requireIsAdmin before allowing them to view pages (checks if admin, if not it redirects them)
  #see   http://stackoverflow.com/questions/5056451/redirect-to-login-page-if-user-not-logged-in

  ########################################
  # Different Actions (pages with views) #
  ########################################
  
  def index
    @houses = House.all
  end

  def new
    @house = House.new
  end

  def show
    @house = House.find(params[:id])
  end

  def edit
    @house = House.find(params[:id])
  end
  
  def info
    @house = House.find(params[:id])
  end
  
  ##############################
  # all pages without own view #
  ##############################

  def create
    @house = House.new(house_params)
  
    if @house.save
      redirect_to @house
    else
      render 'new'
    end
  end
  
  def update
    @house = House.find(params[:id])
  
    if @house.update(house_params)
      redirect_to @house
    else
      render 'edit'
    end
  end
  
  def destroy
    @house = House.find(params[:id])
    @house.destroy
  
    redirect_to houses_path
  end

  #######################################################
  # private functions, not controller actions for pages #
  #######################################################
  
  private
    def house_params
      params.require(:house).permit(:address, :lat, :long, :price, :sqft, :amenities, :contact_info, :pictures)
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
