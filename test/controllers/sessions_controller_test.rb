require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:Test)
  end
  
  test "should get new" do #this is a automatic test
    get :new
    assert_response :success
  end
  
  #test "create" do
  #  post :create, session: {email: @user.email}
  #  @user.authenticate(params[:session]['testing'])
  #  #assert_response :success
  #  assert_redirected_to home_user_path(current_user)
  #end

end
