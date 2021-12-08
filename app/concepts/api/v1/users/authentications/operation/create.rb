# frozen_string_literal: true

module Api::V1::Users::Authentications::Operation
  class Create < ApplicationOperation
    step :find_user
    step :authenticate
    step :validate_user
    step :create_session

    def find_user(params)
      user = User.find_by(email: params[:email])
      if user
        Success({ user: user, password: params[:password] })
      else
        Failure({ errors: [{ email: I18n.t('users.authentications.operation.create.email') }] })
      end
    end

    def authenticate(data)
      auth_user = data[:user].authenticate(data[:password])
      if auth_user
        Success(auth_user)
      else
        Failure({ errors: [{ password: I18n.t('users.authentications.operation.create.password') }] })
      end
    end

    def validate_user(auth_user)
      if auth_user.confirmed?
        Success(auth_user)
      else
        Failure({ errors: [{ email: I18n.t('users.authentications.operation.create.confirmation') }] })
      end
    end

    def create_session(auth_user)
      payload = { user_id: auth_user.id }
      session = JWTSessions::Session.new(payload: payload)
      Success(session.login)
    end
  end
end
