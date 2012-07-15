require "minitest_helper"

describe User, :authentications do

  before do
    @mike = users :mike
    @coby = users :coby
  end

  it "can add an GitHub authentication" do
    assert @mike.authentications
  end

  it "can create an authentication" do
    assert_equal 0, @mike.authentications.count

    github = @mike.add_authentication :github, 123
    @mike.reload
    github.reload

    assert_equal 1, @mike.authentications.count
    assert_equal "github", github.provider
    assert_equal "123", github.uid
  end

  it "user can have more than one authentication per provider" do
    assert_equal 0, @mike.authentications.count

    github = @mike.add_authentication :github, 123

    assert_equal 1, @mike.authentications.count

    github = @mike.add_authentication :github, 456

    assert_equal 2, @mike.authentications.count
  end

  it "doesn't allow the same provider authentication across users" do
    github1 = @mike.add_authentication :github, 123
    github2 = @coby.add_authentication :github, 123

    assert github1.valid?
    refute github2.valid?

    assert_equal 1, @mike.authentications.count
    assert_equal 0, @coby.authentications.count
  end

end
