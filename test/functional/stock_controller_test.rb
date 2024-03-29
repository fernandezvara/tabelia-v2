require 'test_helper'

class StockControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get gallery" do
    get :gallery
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

end
