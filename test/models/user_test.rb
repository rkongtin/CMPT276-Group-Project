require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  #Names of tests were designed to be self-explanatory
  #assert_not user.save, assertions must always be true, assert_nots must be false, so if user.save returns false (it didn't save), assert_not will be correct
  
  def setup
    @pic = 'http://s1.narvii.com/image/mud4owqv2tonms3hkdpbyxbpy4imm3zh_hq.jpg'
  end
  
  test "nameNotNil" do
    user = User.new(:email => 'test@sfu.ca', :password => 'password', :password_confirmation => 'password')
    assert_not user.save
  end
  
  test "emailNotNil" do
    user = User.new(:name => 'test@sfu.ca', :password => 'password', :password_confirmation => 'password')
    assert_not user.save
  end
  
  test "passNotNil" do
    user = User.new(:name => 'test', :email => 'test@sfu.ca', :password => '')
    assert_not user.save
  end
  
  test "passConfirmNotNull" do
    user = User.new(:name => 'test', :email => 'test@sfu.ca', :password => 'password', :password_confirmation => '')
    assert_not user.save
  end
  
  test "pass_passConfirmMatch" do
    user = User.new(:name => 'test', :email => 'test@sfu.ca', :password => 'password', :password_confirmation => 'p@$$w0rd')
    assert_not user.save
  end
  
  test "emailNotTaken" do
    user = User.new(:name => 'test', :email => 'test@sfu.ca', :password => 'password', :password_confirmation => 'password', :pictures => @pic)
    user1 = User.new(:name => 'test1', :email => 'test@sfu.ca', :password => '1password', :password_confirmation => '1password', :pictures => @pic)
    assert user.save #user should be fine
    assert_not user1.save #user1 shouldn't be as email already taken
  end
  
  test "emailDowncase" do
    user = User.new(:name => 'test', :email => 'TEST@sfu.ca', :password => 'password', :password_confirmation => 'password', :pictures => @pic)
    user.save
    assert user.email == 'test@sfu.ca'
  end
  
  test "validEmail" do
    user = User.new(:name => 'test', :email => 'testsfu.ca', :password => 'password', :password_confirmation => 'password')
    assert_not user.save
  end
  
  test "passLen" do
    user = User.new(:name => 'test', :email => 'test@sfu.ca', :password => '122', :password_confirmation => '122')
    assert_not user.save
  end
  
  test "passSecure" do
    user = User.new(:name => 'test', :email => 'test@sfu.ca', :password => 'password', :password_confirmation => 'password')
    user.save
    assert user.password_digest != 'password' #password should be hashed, and therefore not stored as 'password', password_digest is the field in the DB
  end
  
  test "nameNotLen0" do
    user = User.new(:name => '', :email => 'test@sfu.ca', :password => 'password', :password_confirmation => 'password')
    assert_not user.save
  end
  
  test "emailNotLen0" do
    user = User.new(:name => 'test', :email => '', :password => 'password', :password_confirmation => 'password')
    assert_not user.save
  end
  
  test "adminNotNull" do
    user = User.new(:name => 'test', :email => 'test@sfu.ca', :password => 'password', :password_confirmation => 'password')
    assert user.admin == true || user.admin == false #admin val should be true or false, not null/nil (not sure which it is in ruby)
  end
  
end
