require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = users(:valid)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "should be invalid without a password" do
    assert users(:no_password).invalid?
  end

  test "should authenticate with the correct password" do
    assert @user.authenticate('password')
  end

  test "should not authenticate with an incorrect password" do
    assert_not @user.authenticate('incorrect_password')
  end

  test "should allow a password change" do
    assert @user.update_attributes(password: 'new_password')
    assert @user.authenticate("new_password")
  end

  test "should not allow a short password" do
    assert_not @user.update_attributes(password: 'pass')
  end

end
