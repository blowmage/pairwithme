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

end
