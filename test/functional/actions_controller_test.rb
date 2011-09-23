require 'test_helper'

class ActionsControllerTest < ActionController::TestCase
  test "should get follow" do
    get :follow
    assert_response :success
  end

  test "should get unfollow" do
    get :unfollow
    assert_response :success
  end

  test "should get like" do
    get :like
    assert_response :success
  end

  test "should get unlike" do
    get :unlike
    assert_response :success
  end

end
