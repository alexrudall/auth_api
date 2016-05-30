class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def refresh_token
    command = RefreshToken.call(request.headers[:authorization])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def decode_token
    user = AuthorizeApiRequest.call(request.headers).result

    if user.present?
      render json: UserSerializer.new(user).to_json
    else
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

end
