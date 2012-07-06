require "minitest_helper"

describe Account do
  before do
    @valid_params = { provider: "github", uid: 123 }
  end

  it "needs to belong to a user" do
    user = User.create name: "Mike Moore", username: "blowmage",
                       email: "mike@blowmage.com", password: "p@ssw0rd"
    # Refactor to the following:
    # account = user.add_account :github, "USERTOKEN"
    account = user.accounts.build provider: "github", uid: 123

    assert account.user
  end

  it "can be be valid" do
    account = Account.new @valid_params
    assert account.valid?
  end

  it "needs provider to be valid" do
    params = @valid_params.clone
    params.delete :provider
    account = Account.new params
    refute account.valid?
    assert account.errors[:provider]
  end

  it "needs uid to be valid" do
    params = @valid_params.clone
    params.delete :uid
    account = Account.new params
    refute account.valid?
    assert account.errors[:uid]
  end
end
