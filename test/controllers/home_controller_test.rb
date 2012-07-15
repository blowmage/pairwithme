require "minitest_helper"

describe HomeController do

  it "should return successfully" do
    get :index
    assert_response :success
  end

  describe :index do
    it "should return successfully again" do
      get :index
      assert_response :success
    end
  end

end
