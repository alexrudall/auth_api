require 'test_helper'

class JsonWebTokenTest < ActiveSupport::TestCase
  setup do
    @token = JsonWebToken.encode(user_id: '1')
  end

  test 'should be decodable' do
    assert JsonWebToken.decode(@token)[:user_id] == '1'
  end

  test 'should be valid within two hours' do
    Timecop.freeze(119.minutes.from_now) do
      assert JsonWebToken.decode(@token).present?
    end
  end

  test 'should expire after two hours' do
    Timecop.freeze(121.minutes.from_now) do
      assert JsonWebToken.decode(@token).nil?
    end
  end
end
