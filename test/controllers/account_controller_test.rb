require "minitest_helper"

describe AccountController do

  before do
    @mike = users :mike
    @session = @mike.add_session 1.day.from_now, 1.hour
  end

  it "should get index" do
    get :index, username: @mike.username
    assert_response :success
  end

  it "should get reserve" do
    sign_in users(:coby)
    post :reserve, username: @mike.username, id: @session.id
    assert_response :success
  end

end
