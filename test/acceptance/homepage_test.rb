require "minitest_helper"

describe "Homepage Acceptance Test" do
  it "must be a real test" do
    get root_path
    assert_response :success
  end
end
