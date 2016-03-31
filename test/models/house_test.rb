require 'test_helper'

class HouseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @pic = 'http://s1.narvii.com/image/mud4owqv2tonms3hkdpbyxbpy4imm3zh_hq.jpg'
  end
  
  test "valid" do #test a random thing that SHOULD be valid
    house = House.new(:address => "1111 test av", :price => 60000, :sqft => 500, :amenities => "Stuff, please can we use square metres?", :contact_info => "911", :pictures => @pic)
    assert house.save
  end
  
  test "addressNotBlank" do
    house = House.new(:address => "", :price => 60000, :sqft => 500, :amenities => "Stuff, please can we use square metres?", :contact_info => "911", :pictures => @pic)
    assert_not house.save
  end
  
  test "priceNotNull" do
    house = House.new(:address => "1111 test av", :sqft => 500, :amenities => "Stuff, please can we use square metres?", :contact_info => "911", :pictures => @pic)
    assert_not house.save
  end
  
  test "sqftNotNull" do
    house = House.new(:address => "1111 test av", :price => 60000, :amenities => "Stuff, please can we use square metres?", :contact_info => "911", :pictures => @pic)
    assert_not house.save
  end
  
  test "contactInfoNotNull" do
    house = House.new(:address => "1111 test av", :price => 60000, :sqft => 500, :amenities => "Stuff, please can we use square metres?", :pictures => @pic)
    assert_not house.save
  end
  
  test "ammenitiesNotNull" do
    house = House.new(:address => "1111 test av", :price => 60000, :sqft => 500, :contact_info => "911", :pictures => @pic)
    assert_not house.save
  end
  
  test "picturesNotNull" do
    house = House.new(:address => "1111 test av", :price => 60000, :sqft => 500, :amenities => "Stuff, please can we use square metres?", :contact_info => "911")
    assert_not house.save
  end
  
  test "priceIsNum" do
    house = House.new(:address => "1111 test av", :price => "0XAF5", :sqft => 500, :amenities => "Stuff, please can we use square metres?", :contact_info => "911", :pictures => @pic)
    assert_not house.save
  end
  
  test "sqftIsNum" do
    house = House.new(:address => "1111 test av", :price => 60000, :sqft => "50a12", :amenities => "Stuff, please can we use square metres?", :contact_info => "911", :pictures => @pic)
    assert_not house.save
  end
  
end
