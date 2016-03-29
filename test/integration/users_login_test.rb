require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  
  #Remember, to reference users in the test DB (located in test/fixtures), use the form MODEL(:THING)
  #so example, users(:testAdmin)
  
  def setup
    #@admin = User.new(:name => 'test', :email => 'test@sfu.ca', :password => '123456', :password_confirmation => '123456', :admin => true)
    #@admin.save
    @admin = users(:testAdmin)
    @user = users(:test)
    @pass = "testing" #universal password for ease of use
  end
  
  #test "login with invalid information" do
    #get login_path
    #post login_path, session: { email: @user.email, password: '123456' }
    #assert is_logged_in?
    #assert_redirected_to @user
    #follow_redirect!
    #assert_template 'users/show'
    #assert_select "a[href=?]", login_path, count: 0
    #assert_select "a[href=?]", logout_path
    #assert_select "a[href=?]", user_path(@user)
    #delete logout_path
    #assert_not is_logged_in?
    #assert_redirected_to root_url
    #follow_redirect!
    #assert_select "a[href=?]", login_path
    #assert_select "a[href=?]", logout_path,      count: 0
    #assert_select "a[href=?]", user_path(@user), count: 0
  #end
  
  test "login" do
    get '/login'
    assert_response :success
    
    #login
    post_via_redirect login_path, session: { email: "admin@sfu.ca", password: "testing" }
    assert_equal home_user_path(users(:testAdmin)), path
    
  end
  
  test "badLogin" do
    #go to login page
    get '/login'
    assert_response :success
    
    post_via_redirect login_path, session: { email: @admin.email, password: "kashdfkls" }
    assert_equal login_path, path #assert we're still having to login
  end
  
  test "noAccessToOtherHome" do
    login(:test)
    #try accessing someone elses home
    get_via_redirect home_user_path(@admin)
    assert_equal user_path(@user), path #should be redirected to their profile
  end
  
  
  ###################
  # Private Methods #
  ###################
  
  private
  
    def login(user) #private method to login to some user
      u = users(user)
      #get to page
      get login_path
      assert_response :success
      #login
      post_via_redirect login_path, session: { email: u.email, password: @pass }
      assert_equal home_user_path(u), path
    end
    
  
  
  ###########
  # Helpers #
  ###########
  
  #Helper	Purpose
  
  #https?	                              	                                Returns true if the session is mimicking a secure HTTPS request.
  #https!	                              	                                Allows you to mimic a secure HTTPS request.
  #host!	                             	                                  Allows you to set the host name to use in the next request.
  #redirect?	                          	                                Returns true if the last request was a redirect.
  #follow_redirect!	                    	                                Follows a single redirect response.
  #request_via_redirect(http_method, path, [parameters], [headers])       Allows you to make an HTTP request and follow any subsequent redirects.
  #post_via_redirect(path, [parameters], [headers])	                      Allows you to make an HTTP POST request and follow any subsequent redirects.
  #get_via_redirect(path, [parameters], [headers])	                      Allows you to make an HTTP GET request and follow any subsequent redirects.
  #patch_via_redirect(path, [parameters], [headers])	                    Allows you to make an HTTP PATCH request and follow any subsequent redirects.
  #put_via_redirect(path, [parameters], [headers])	                      Allows you to make an HTTP PUT request and follow any subsequent redirects.
  #delete_via_redirect(path, [parameters], [headers])	                    Allows you to make an HTTP DELETE request and follow any subsequent redirects.
  #open_session	                                                          Opens a new session instance.

end
