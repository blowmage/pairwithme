require "minitest_helper"

describe User do

  it "exists" do
    mike = users :mike
    assert mike
  end

  it "can reserve another user's session" do
    mike = users :mike
    session = mike.add_session 2.hours.from_now, 1.hour
    coby = users :coby
    coby.reserve session
    assert_equal coby, session.requester
  end

  it "cannot reserve its own sessions"

end
