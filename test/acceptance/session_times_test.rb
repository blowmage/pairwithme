require "minitest_helper"

describe "Session Times Acceptance Test" do
  describe "User Create Times For Pairing" do
    it "user can add a new pairing time session" do
      mike = users :mike

      pairing_start = 1.day.from_now
      duration = 1.hour

      pairing_session = mike.add_session pairing_start, duration

      assert_equal 1, mike.sessions.count, "Mike should have just one pairing time"
      assert_equal pairing_session, mike.sessions.first
      assert_equal pairing_start, pairing_session.start_at
      assert_equal pairing_start + duration, pairing_session.end_at
    end
  end

  describe "User can see times for other users" do
    before do
      @mike = users :mike
      # Add two sessions in the past
      @mike.add_session 3.days.ago, 90.minutes
      @mike.add_session 2.days.ago, 2.hours
      # Add three sessions in the future
      @mike.add_session 2.hours.from_now, 1.hour
      @mike.add_session 1.day.from_now,   90.minutes
      @mike.add_session 2.days.from_now,  2.hours
    end

    it "can see the upcoming sessions" do
      assert_equal 3, @mike.upcoming_sessions.count
    end

    # Available? Unavialable?
  end

  describe "User can reserve another user's available sessions" do
    before do
      @mike = users :mike
      @coby = users :coby
      # Add three sessions in the future
      @first  = @mike.add_session 2.hours.from_now, 1.hour
      @second = @mike.add_session 3.hours.from_now, 1.hour
      @third  = @mike.add_session 4.hours.from_now, 1.hour
    end

    it "lists available sessions" do
      assert_equal 3, @mike.available_sessions.count
    end

    it "can reserve sessions" do
      assert_difference "@mike.available_sessions.count", -1 do
        @coby.reserve! @mike.available_sessions.sample
      end
    end

    # Available? Unavailable?
  end
end
