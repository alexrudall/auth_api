require 'test_helper'

class AuthorizeApiRequestTest < ActiveSupport::TestCase
  setup do
    @user = users(:valid)
    @token = JsonWebToken.encode(user_id: @user.id)
  end

  test 'should be valid within one hour' do
    Timecop.freeze(59.minutes.from_now) do
      assert AuthorizeApiRequest.call(authorization: @token).result == @user
    end
  end

  test 'should expire after one hour' do
    Timecop.freeze(61.minutes.from_now) do
      assert AuthorizeApiRequest.call(authorization: @token).result.nil?
    end
  end
end
