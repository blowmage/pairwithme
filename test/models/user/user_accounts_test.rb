require "minitest_helper"

describe User, :accounts do

  before do
    @mike = users(:mike)
    @coby = users(:coby)
  end

  it "can add an GitHub account" do
    assert @mike.accounts
  end

  it "can create an account" do
    assert_equal 0, @mike.accounts.count

    github = @mike.add_account :github, 123
    @mike.reload
    github.reload

    assert_equal 1, @mike.accounts.count
    assert_equal "github", github.provider
    assert_equal "123", github.uid
  end

  it "user can have more than one account per provider" do
    assert_equal 0, @mike.accounts.count

    github = @mike.add_account :github, 123

    assert_equal 1, @mike.accounts.count

    github = @mike.add_account :github, 456

    assert_equal 2, @mike.accounts.count
  end

  it "doesn't allow the same provider account across users" do
    github1 = @mike.add_account :github, 123
    github2 = @coby.add_account :github, 123

    assert github1.valid?
    refute github2.valid?

    assert_equal 1, @mike.accounts.count
    assert_equal 0, @coby.accounts.count
  end

end
