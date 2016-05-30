require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid)
    @token = AuthenticateUser.call(@user.email, 'password').result
  end

  test "should get index" do
    get users_url, headers: { authorization: @token }
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { email: @user.email, password: 'password', username: @user.username } }, headers: { authorization: @token }
    end

    assert_response 201
  end

  test "should show user" do
    get user_url(@user), headers: { authorization: @token }
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, password: 'password', username: @user.username } }, headers: { authorization: @token }
    assert_response 200
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user), headers: { authorization: @token }
    end

    assert_response 204
  end

end
