require "minitest_helper"

describe "User Create Times For Pairing Integration Test" do

  it "user can add a new pairing time session" do
    mike = User.create name: "Mike Moore", username: "blowmage",
                       email: "mike@blowmage.com", password: "p@ssw0rd"

    pairing_start = 1.day.from_now
    duration = 1.hour

    pairing_session = mike.add_session(pairing_start, duration)

    assert_equal 1, mike.sessions.count, "Mike should have just one pairing time"
    assert_equal pairing_session, mike.sessions.first
    assert_equal pairing_start, pairing_session.start_at
    assert_equal pairing_start + duration, pairing_session.end_at
  end

end
