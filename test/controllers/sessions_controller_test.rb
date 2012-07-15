require "minitest_helper"

describe SessionsController do

  before do
    mike = users(:mike)
    sign_in mike
    @session = mike.add_session 1.day.from_now, 1.hour
  end

  it "must get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sessions)
  end

  it "must get new" do
    get :new
    assert_response :success
  end

  it "must create session" do
    assert_difference('Session.count') do
      post :create, session: { start_at: 2.days.from_now, duration: 30.minutes }
    end

    assert_redirected_to session_path(assigns(:session))
  end

  it "must show session" do
    get :show, id: @session.to_param
    assert_response :success
  end

  it "must get edit" do
    get :edit, id: @session.to_param
    assert_response :success
  end

  it "must update session" do
    put :update, id: @session.to_param, session: { start_at: 3.days.from_now, duration: 90.minutes }
    assert_redirected_to session_path(assigns(:session))
  end

  it "must destroy session" do
    assert_difference('Session.count', -1) do
      delete :destroy, id: @session.to_param
    end

    assert_redirected_to sessions_path
  end

end
