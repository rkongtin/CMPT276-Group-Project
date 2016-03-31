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
    @school = schools(:one)
  end
  
  test "login" do
    get '/login'
    assert_response :success
    
    #login
    post_via_redirect login_path, session: { email: "admin@sfu.ca", password: "testing" }
    assert_equal home_user_path(@admin), path
    
  end
  
  test "badLogin" do
    #go to login page
    get '/login'
    assert_response :success
    
    post_via_redirect login_path, session: { email: @admin.email, password: "kashdfkls" }
    assert_equal login_path, path #assert we're still having to login
  end
  
  ##################################################################
  # do the tests to make sure users can't access others user pages # #note, this also has the benifit of testing that non-admins can't access admin pages :)
  ##################################################################
  test "noAccessOtherHome" do
    login(:test)
    get_via_redirect home_user_path(@admin)
    assert_equal user_path(@user), path
  end
  test "noAccessOtherProfile" do
    login(:test)
    #test access to users profile page (show)
    get_via_redirect users_path(@admin)
    assert_equal user_path(@user), path
  end
  test "noAccessNotAdminUsersIndex" do
    login(:test)
    get_via_redirect users_path
    assert_equal user_path(@user), path
  end
  test "noAccessOtherSettings" do
    login(:test)
    get_via_redirect settings_user_path(@admin)
    assert_equal user_path(@user), path
  end
  test "noAccessOtherChangePass" do
    login(:test)
    #test access to password change page
    get_via_redirect changePassword_user_path(@admin)
    assert_equal user_path(@user), path
  end
  test "noAccessOtherChangeEmail" do
    login(:test)
    get_via_redirect changeEmail_user_path(@admin)
    assert_equal user_path(@user), path
  end
  test "noAccessOtherMakeAdmin" do
    login(:test)
    get_via_redirect makeAdmin_user_path(@admin)
    assert_equal user_path(@user), path
  end
  test "noAccessOtherEdit" do
    login(:test)
    get_via_redirect edit_user_path(@admin)
    assert_equal user_path(@user), path
  end
  
  #############################################################
  # do the tests to make sure users can't access update users #
  #############################################################
  
  test "noAccessOtherMakeAdminUpdate" do
    login(:test)
    patch_via_redirect makeAdmin_update_user_path(@admin), admin: false
    assert_equal user_path(@user), path
    assert @admin.admin == true
  end
  test "noAccessOtherChangePasswordUpdate" do
    login(:test)
    patch_via_redirect changePassword_update_user_path(@admin), user: {password: "123456", password_digest: "123456"}
    assert_equal user_path(@user), path
    #log in to admin to test now
    login(:testAdmin)#password shouldn't have been changed
    assert_equal home_user_path(@admin), path
  end
  test "noAccessOtherChangeEmailUpdate" do
    login(:test)
    patch_via_redirect changeEmail_update_user_path(@admin), email: "NOMORE@sfu.ca"
    assert_equal user_path(@user), path
    #log in to admin to test now
    login(:testAdmin)#email shouldn't have been changed
    assert_equal home_user_path(@admin), path
  end
  
  ###########################################################################
  # do the tests to make sure users/not logged in can't access school pages # #admins can, this only tests normal users (I'm merging logged in/out so I write less also)
  ###########################################################################
  
  test "noAccessSchoolsIndex" do
    get_via_redirect schools_path
    assert_equal sessions_new_path, path
    login(:test)
    get_via_redirect schools_path
    assert_equal user_path(@user), path
  end
  
  test "noAccessSchoolsNew" do
    get_via_redirect schools_new_path
    assert_equal sessions_new_path, path
    login(:test)
    get_via_redirect schools_new_path
    assert_equal user_path(@user), path
  end
  
  test "noAccessSchoolsEdit" do
    get_via_redirect schools_edit_path(@school)
    assert_equal sessions_new_path, path
    login(:test)
    get_via_redirect schools_edit_path(@school)
    assert_equal user_path(@user), path
  end
  
  test "noAccessSchoolsShow" do
    get_via_redirect school_path(@school)
    assert_equal sessions_new_path, path
    login(:test)
    get_via_redirect school_path(@school)
    assert_equal user_path(@user), path
  end
  
  #########################################################################
  # do the tests to make sure non-logged in users can't access user pages #
  #########################################################################
  test "notLogInHomePage" do
    get_via_redirect home_user_path(@admin)
    assert_equal sessions_new_path, path
  end
  test "notLogInProfile" do
    #test access to users profile page (show)
    get_via_redirect users_path(@admin)
    assert_equal sessions_new_path, path
  end
  test "notLogInUsersIndex" do
    get_via_redirect users_path
    assert_equal sessions_new_path, path
  end
  test "notLogInSettings" do
    get_via_redirect settings_user_path(@admin)
    assert_equal sessions_new_path, path
  end
  test "notLogInChangePass" do
    #test access to password change page
    get_via_redirect changePassword_user_path(@admin)
    assert_equal sessions_new_path, path
  end
  test "notLogInChangeEmail" do
    get_via_redirect changeEmail_user_path(@admin)
    assert_equal sessions_new_path, path
  end
  test "notLogInMakeAdmin" do
    get_via_redirect makeAdmin_user_path(@admin)
    assert_equal sessions_new_path, path
  end
  test "notLogInEdit" do
    get_via_redirect edit_user_path(@admin)
    assert_equal sessions_new_path, path
  end
  
  #########################################################################
  # do the tests to make sure non-logged in users can't update user pages #
  #########################################################################
  
  test "notLogInMakeAdminUpdate" do #do the tests to make sure non-logged can't update users
    patch_via_redirect makeAdmin_update_user_path(@admin), admin: false
    assert_equal sessions_new_path, path
    assert @admin.admin == true
  end
  test "notLogInChangePasswordUpdate" do #do the tests to make sure non-logged can't update users
    patch_via_redirect changePassword_update_user_path(@admin), user: {password: "123456", password_digest: "123456"}
    assert_equal sessions_new_path, path
    login(:testAdmin)#password shouldn't have been changed
    assert_equal home_user_path(@admin), path
  end
  test "notLogInChangeEmailUpdate" do #do the tests to make sure non-logged can't update users
    patch_via_redirect changeEmail_update_user_path(@admin), email: "NOMORE@sfu.ca"
    assert_equal sessions_new_path, path
    login(:testAdmin)#email shouldn't have been changed
    assert_equal home_user_path(@admin), path
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
