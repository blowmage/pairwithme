require "minitest_helper"

describe Account do
  before do
    @mike = users(:mike)
    @valid_params = { provider: "github", uid: 123 }
  end

  it "needs to belong to a user" do
    account = @mike.accounts.build provider: "github", uid: 123

    assert_equal @mike, account.user
  end

  it "can be be valid" do
    account = @mike.accounts.build @valid_params
    assert account.valid?
  end

  it "needs provider to be valid" do
    params = @valid_params.clone
    params.delete :provider
    account = @mike.accounts.build params
    refute account.valid?
    assert account.errors[:provider]
  end

  it "needs uid to be valid" do
    params = @valid_params.clone
    params.delete :uid
    account = @mike.accounts.build params
    refute account.valid?
    assert account.errors[:uid]
  end
end
