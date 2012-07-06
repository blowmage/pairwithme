require "minitest_helper"

class UserTest < MiniTest::Rails::ActiveSupport::TestCase
  test "it exists" do
    assert User
  end
end
