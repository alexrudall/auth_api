require 'test_helper'

class JsonWebTokenTest < ActiveSupport::TestCase

  setup do
    @token = JsonWebToken.encode(user_id: '1')
  end

  test "should be decodable" do
    assert JsonWebToken.decode(@token)[:user_id] == '1'
  end

  test "should be valid within the first hour" do
    Timecop.freeze(Time.now + 59.minutes) do
      assert JsonWebToken.decode(@token).present?
    end
  end

  test "should expire after one hour" do
    Timecop.freeze(Time.now + 61.minutes) do
      assert JsonWebToken.decode(@token).nil?
    end
  end

end
