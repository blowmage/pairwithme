require "minitest_helper"

describe User do
  it "exists" do
    # mike = users(:mike)
    mike = User.new name: "Mike Moore", username: "blowmage",
                    email: "mike@blowmage.com", password: "p@ssw0rd"
    assert mike
  end

  # it "can add a pairing time" user.add_session

end
