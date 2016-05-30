module Api::V1
  class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request

    def authenticate
      command = AuthenticateUser.call(params[:email], params[:password])
      render_command(command)
    end

    def refresh_token
      command = RefreshToken.call(request.headers[:authorization])
      render_command(command)
    end

    def decode_token
      user = AuthorizeApiRequest.call(request.headers).result

      if user.present?
        render json: UserSerializer.new(user).to_json
      else
        render json: { error: 'Invalid token' }, status: :unauthorized
      end
    end

    private

    def render_command(command)
      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end
  end
end
