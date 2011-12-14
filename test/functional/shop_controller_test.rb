require 'test_helper'

class ShopControllerTest < ActionController::TestCase
  test "should get popular" do
    get :popular
    assert_response :success
  end

  test "should get photos" do
    get :photos
    assert_response :success
  end

  test "should get paintings" do
    get :paintings
    assert_response :success
  end

end
