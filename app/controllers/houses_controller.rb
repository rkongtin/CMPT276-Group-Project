class HousesController < ApplicationController
  
  before_filter :requireIsAdmin #require them to be admin to view these pages, otherwise redirect them. Code is run right away
  #see   http://stackoverflow.com/questions/5056451/redirect-to-login-page-if-user-not-logged-in

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

  private
    def house_params
      params.require(:house).permit(:address, :price, :sqft, :amenities, :contact_info, :pictures)
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
    #could possibly have used
    #if current_user.admin?
    #  # do something
    #end

end
