class RefreshToken
  prepend SimpleCommand

  def initialize(token)
    @token = token
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :token

  def user
    id = JsonWebToken.decode(@token)[:user_id] if JsonWebToken.decode(token)
    user = User.find(id) if id
    return user if user

    errors.add :refresh_token, 'invalid credentials'
    nil
  end
end
