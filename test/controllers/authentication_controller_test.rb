require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid)
  end

  test "should authenticate user" do
    post authenticate_url, params: {email: @user.email, password: 'password' }
    assert_response :success
  end

  test "should not authenticate user with incorrect password" do
    post authenticate_url, params: {email: @user.email, password: 'incorrect' }
    assert_response :unauthorized
  end

  test "should not authenticate user with incorrect email" do
    post authenticate_url, params: {email: 'incorrect', password: 'password' }
    assert_response :unauthorized
  end

end
