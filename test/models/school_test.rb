require 'test_helper'

class SchoolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "validSchool" do
    school = School.new(:name => 'test', :address => 'test', :lat =>50.41, :long => 32.60)
    assert school.save
  end
  
  test "nameNotNull" do
    school = School.new(:name => '', :address => 'test', :lat => 1, :long => 1)
    assert_not school.save
  end
  
  test "addressNotNull" do
    school = School.new(:name => 'test', :address => '', :lat => 1, :long => 1)
    assert_not school.save
  end
  
  test "latAndLongCorrect" do
    #first, they must be numbers
    school = School.new(:name => 'test', :address => 'test', :lat => 'a', :long => 1)
    school1 = School.new(:name => 'test', :address => 'test', :lat => 1, :long => 'a')
    assert_not school.save
    assert_not school1.save
    #now test for blank fields
    school = School.new(:name => 'test', :address => 'test', :lat => 1)
    school1 = School.new(:name => 'test', :address => 'test', :long => 1)
    assert_not school.save
    assert_not school1.save
  end

end
