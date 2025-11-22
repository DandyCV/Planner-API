# frozen_string_literal: true

class ApiController < ActionController::API
  include Response
  include JWTSessions::RailsAuthorization

  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized
  before_action :authorize_access_session

  private

  def authorize_access_session
    authorize_access_request!
  end

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    respond_with(
      status: 401,
      entity: { errors: [{ message: I18n.t('users.authentications.errors.unauthorized') }] }
    )
  end
end
