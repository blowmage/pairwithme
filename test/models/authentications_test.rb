require "minitest_helper"

describe Authentication do
  before do
    @mike = users :mike
    @valid_params = { provider: "github", uid: 123 }
  end

  it "needs to belong to a user" do
    authentication = @mike.authentications.build provider: "github", uid: 123

    assert_equal @mike, authentication.user
  end

  it "can be be valid" do
    authentication = @mike.authentications.build @valid_params
    assert authentication.valid?
  end

  it "needs provider to be valid" do
    params = @valid_params.clone
    params.delete :provider
    authentication = @mike.authentications.build params
    refute authentication.valid?
    assert authentication.errors[:provider]
  end

  it "needs uid to be valid" do
    params = @valid_params.clone
    params.delete :uid
    authentication = @mike.authentications.build params
    refute authentication.valid?
    assert authentication.errors[:uid]
  end
end
