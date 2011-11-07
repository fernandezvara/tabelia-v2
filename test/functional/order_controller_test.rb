require 'test_helper'

class OrderControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get success" do
    get :success
    assert_response :success
  end

  test "should get failure" do
    get :failure
    assert_response :success
  end

end
