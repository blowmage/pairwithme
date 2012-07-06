require "minitest_helper"

describe Session do
  before do
    @mike = users(:mike)
    @session = @mike.add_session Date.tomorrow + 6.hours, 2.hours
  end

  it "must be valid" do
    @session.valid?.must_equal true
  end

  it "has an owner" do
    assert @session.owner
  end

  it "has a duration" do
    assert_equal 2.hours, @session.duration
  end
end
