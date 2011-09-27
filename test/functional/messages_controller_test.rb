require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get inbox" do
    get :inbox
    assert_response :success
  end

  test "should get outbox" do
    get :outbox
    assert_response :success
  end

  test "should get notifications" do
    get :notifications
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get reply" do
    get :reply
    assert_response :success
  end

end
