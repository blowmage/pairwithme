# encoding: UTF-8
require "minitest_helper"

describe User, :username do

  before do
    @mike = users :mike
  end

  it "finds users by their case insensitive username" do
    @mike.username = "BLOWMAGE"
    @mike.save!
    assert_equal User.find_by_username("blowmage"), @mike

    @mike.username = "blowmage"
    @mike.save!
    assert_equal User.find_by_username("BLOWMAGE"), @mike

    @mike.username = "Bl0wM4g3"
    @mike.save!
    assert_equal User.find_by_username("bl0wm4g3"), @mike

    @mike.username = "123456"
    @mike.save!
    assert_equal User.find_by_username("123456"), @mike
  end

  it "can be set to a new, free value" do
    @mike.username = "NOBODYHASTAKENTHISONEYET"
    assert @mike.valid?
  end

  it "is unique across users" do
    coby = users :coby
    @mike.username = coby.username
    refute @mike.valid?
    assert @mike.errors[:username].include?("has already been taken")
  end

  it "only allows alphanumeric characters" do
    @mike.username = "-blowmage"
    refute @mike.valid?
    assert @mike.errors[:username].include?("can only have letters, numbers and '_'")

    @mike.username = "blowm☣ge"
    refute @mike.valid?
    assert @mike.errors[:username].include?("can only have letters, numbers and '_'")
  end

  it "cannot be a reserved username" do
    @mike.username = Reserved::USERNAMES.sample
    refute @mike.valid?
    assert @mike.errors[:username].include?("is reserved")
  end

  it "must be 3 characters or larger" do
    @mike.username = "a"
    refute @mike.valid?
    assert @mike.errors[:username].include?("is too short (minimum is 3 characters)")
  end

  it "must be 32 characters or smaller" do
    @mike.username = "abcdefghijklmnopqrstuvwxyz0123456789"
    refute @mike.valid?
    assert @mike.errors[:username].include?("is too long (maximum is 32 characters)")
  end

end
