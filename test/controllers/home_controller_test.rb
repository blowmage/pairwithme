require "minitest_helper"

class HomeControllerTest < MiniTest::Rails::ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end

end
