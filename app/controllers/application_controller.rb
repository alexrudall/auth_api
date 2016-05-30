class ApplicationController < ActionController::API
  before_action :authenticate_request
  attr_reader :current_user

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    user_not_authorized unless @current_user
  end

  def user_not_authorized
    render json: { error: 'Not Authorized' }, status: 401
  end
end
