require "minitest_helper"

describe User, :reserve! do

  it "can reserve another user's session" do
    mike = users :mike
    session = mike.add_session 2.hours.from_now, 1.hour
    coby = users :coby
    coby.reserve! session
    assert_equal coby, session.requester
  end

  it "cannot reserve its own sessions" do
    mike = users :mike
    session = mike.add_session 2.hours.from_now, 1.hour
    assert_raises PairWithMe::CannotReserveSession do
      mike.reserve! session
    end
  end

  describe :can_reserve? do

    it "passes when the session is available" do
      mike = users :mike
      coby = users :coby
      session = mike.add_session 2.hours.from_now, 1.hour
      assert session.available?
      assert coby.can_reserve?(session)
    end

    it "fails when the session is owned by the requester" do
      mike = users :mike
      session = mike.add_session 2.hours.from_now, 1.hour
      assert session.available?
      refute mike.can_reserve?(session)
    end

    it "fails when the session is already reserved" do
      mike = users :mike
      coby = users :coby
      john = users :john
      session = mike.add_session 2.hours.from_now, 1.hour
      assert session.available?
      coby.reserve!(session)
      assert session.reserved?
      refute john.can_reserve?(session)
    end

  end

end
