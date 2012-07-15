require "minitest_helper"

describe Session do
  before do
    @mike = users :mike
    @coby = users :coby
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

  it "is available when not reserved" do
    assert @session.available?
    refute @session.reserved?
  end

  it "is not available when reserved" do
    @coby.reserve(@session)
    refute @session.available?
    assert @session.reserved?
  end
  it "can be reserved"
end
