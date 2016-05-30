require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid)
  end

  test 'should authenticate user' do
    post v1_authenticate_url, params: {
      email: @user.email,
      password: 'password'
    }
    assert_response :success
  end

  test 'should not authenticate user with incorrect password' do
    post v1_authenticate_url, params: {
      email: @user.email,
      password: 'incorrect'
    }
    assert_response :unauthorized
  end

  test 'should not authenticate user with incorrect email' do
    post v1_authenticate_url, params: {
      email: 'incorrect',
      password: 'password'
    }
    assert_response :unauthorized
  end

  test 'should refresh token' do
    @token = AuthenticateUser.call(@user.email, 'password').result
    post v1_refresh_token_url, headers: { authorization: @token }
    assert_response :success
  end

  test 'should not refresh token if it is more than 2 hours old' do
    Timecop.freeze(121.minutes.ago) do
      @token = AuthenticateUser.call(@user.email, 'password').result
    end
    post v1_refresh_token_url, headers: { authorization: @token }
    assert_response :unauthorized
  end

  test 'should decode token' do
    @token = AuthenticateUser.call(@user.email, 'password').result
    get v1_decode_token_url, headers: { authorization: @token }
    assert_response :success
    assert JSON.parse(response.body)['id'] == @user.id
  end

  test 'should not return password in decoded token' do
    @token = AuthenticateUser.call(@user.email, 'password').result
    get v1_decode_token_url, headers: { authorization: @token }
    assert_response :success
    assert JSON.parse(response.body)['password_digest'].nil?
  end

  test 'should not decode token if it is more than 1 hour old' do
    Timecop.freeze(61.minutes.ago) do
      @token = AuthenticateUser.call(@user.email, 'password').result
    end
    get v1_decode_token_url, headers: { authorization: @token }
    assert_response :unauthorized
  end
end
