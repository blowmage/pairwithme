require "minitest_helper"

describe "User Can Associate Their GitHub Account Integration Test" do

  it "allows users to associate their GitHub account" do
    mike = users(:mike)

    github = mike.add_authentication :github, 123

    assert github.valid?
  end

end
