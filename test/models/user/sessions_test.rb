require "minitest_helper"

describe User, :accounts do

  before do
    @mike = users :mike
    @coby = users :coby
  end

  it "can add a pairing time" do
    assert_difference "@mike.sessions.count", 3 do
      @mike.add_session 2.days.from_now, 90.minutes
      @mike.add_session 3.days.from_now, 1.hour
      @mike.add_session 4.days.from_now, 15.minutes
    end
  end

  it "has upcoming session times" do
    assert_difference "@mike.upcoming_sessions.count", 2 do
      # Add two in the future
      @mike.add_session 2.days.from_now, 90.minutes
      @mike.add_session 3.days.from_now, 2.hours
      # Add three in the past
      @mike.add_session 2.days.ago, 90.minutes
      @mike.add_session 3.days.ago, 1.hour
      @mike.add_session 4.days.ago, 15.minutes
    end
  end

  describe :available_sessions do

    it "has available session times" do
      assert_difference "@mike.available_sessions.count", 3 do
        # Add three in the future, one is reserved
        @mike.add_session 2.days.from_now, 90.minutes
        @mike.add_session 3.days.from_now, 2.hours
        @mike.add_session 4.days.from_now, 30.minutes
        # Add two in the past, don't show up
        @mike.add_session 2.days.ago, 90.minutes
        @mike.add_session 3.days.ago, 1.hour
      end
    end

    it "has available session times" do
      @mike.add_session 2.days.from_now, 90.minutes
      @mike.add_session 3.days.from_now, 2.hours
      @mike.add_session 4.days.from_now, 30.minutes

      session = @mike.upcoming_sessions.sample
      assert session.available?
      assert_difference "@mike.available_sessions.count", -1 do
        @coby.reserve! session
      end
      assert session.reserved?
      refute @mike.available_sessions.include?(@second)
    end

  end

end
