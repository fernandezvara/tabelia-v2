require 'test_helper'

class FbControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get my" do
    get :my
    assert_response :success
  end

end
