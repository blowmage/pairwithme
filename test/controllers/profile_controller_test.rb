require "minitest_helper"

describe ProfileController do

  it "should display when authenticated" do
    sign_in users(:mike)
    get :index
    assert_response :success
  end

  it "should redirect when unauthenticated" do
    get :index
    assert_redirected_to :new_user_session
  end

end
