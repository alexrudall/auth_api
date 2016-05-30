class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= capped_token(JsonWebToken.decode(http_auth_header))
  end

  def http_auth_header
    if headers[:authorization].present?
      return headers[:authorization].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end

  def capped_token(decoded_token)
    if decoded_token.nil? || Time.at(decoded_token[:exp]) < 1.hour.from_now
      nil
    else
      decoded_token
    end
  end
end
