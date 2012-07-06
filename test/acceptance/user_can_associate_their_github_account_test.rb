require "minitest_helper"

describe "User Can Associate Their GitHub Account Acceptance Test" do

  it "allows users to associate their GitHub account" do
    mike = User.create name: "Mike Moore", username: "blowmage",
                       email: "mike@blowmage.com", password: "p@ssw0rd"

    github = mike.add_account :github, 123

    assert github.valid?
  end

end
