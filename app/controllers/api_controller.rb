# frozen_string_literal: true

class ApiController < ActionController::API
  include Response
  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def not_authorized
    respond_with(
      status: 401,
      entity: { errors: [{ message: I18n.t('users.authentications.errors.unauthorized') }] }
    )
  end
end
