# encoding: UTF-8
require "minitest_helper"

describe User do

  it "exists" do
    @mike = users :mike
    assert @mike
  end

  describe "User.upcoming" do
    before do
      @mike = users :mike
      @coby = users :coby
      @john = users :john

      @mike.add_session 2.days.from_now, 1.hour
      @mike.add_session 4.days.from_now, 1.hour
      @coby.add_session 1.day.from_now, 1.hour
      @john.add_session 3.days.from_now, 1.hour
    end

    it "get the users with upcoming_sessions" do
      assert_equal ["cobyr", "blowmage", "john"], User.upcoming.map(&:username)
    end

    it "doesn't show reserved session" do
      @john.available_sessions.each do |s|
        @mike.reserve! s
      end
      assert_equal ["cobyr", "blowmage"], User.upcoming.map(&:username)
    end
  end

end
