require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get basic" do
    get :basic
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get avatar" do
    get :avatar
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get services" do
    get :services
    assert_response :success
  end

  test "should get basic_update" do
    get :basic_update
    assert_response :success
  end

  test "should get about_update" do
    get :about_update
    assert_response :success
  end

  test "should get avatar_update" do
    get :avatar_update
    assert_response :success
  end

  test "should get privacy_update" do
    get :privacy_update
    assert_response :success
  end

  test "should get services_update" do
    get :services_update
    assert_response :success
  end

end
