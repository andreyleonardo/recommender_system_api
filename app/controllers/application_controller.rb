class ApplicationController < ActionController::API
  include AbstractController::Translation

  # before_action :authenticate_user_from_token!
  before_action :authenticate_request

  attr_reader :current_user
  helper_method :current_user

  respond_to :json

  private

  # Authenticate user by JWT token
  def authenticate_request
    @current_user = AuthenticateApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
