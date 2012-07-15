# encoding: UTF-8
require "minitest_helper"

describe User do

  it "exists" do
    @mike = users :mike
    assert @mike
  end

end
