# frozen_string_literal: true

module Api::V1::Users::Confirmations::Operation
  class Show < ApplicationOperation
    step :decode_token
    step :validate_token
    step :validate_user
    step :update_user

    def decode_token(params)
      data = Api::V1::Lib::Service::EmailToken.decode(params[:email_token])
    rescue JWT::DecodeError
      Failure({ errors: [{ token: I18n.t('users.confirmations.token.invalid') }] })
    else
      Success(data.first)
    end

    def validate_token(data)
      token_expired = DateTime.parse(data['created_at']) < (DateTime.now - Constants::Shared::VALID_TOKEN_TIME)
      return Success(data) unless token_expired

      Failure({ errors: [{ token: I18n.t('users.confirmations.token.expired') }] })
    end

    def validate_user(data)
      user = User.find_by(id: data['id'], email: data['email'], confirmed: false)
      user ? Success(user) : Failure({ errors: [{ token: I18n.t('users.confirmations.token.data') }] })
    end

    def update_user(user)
      Success(user.update(confirmed: true))
    end
  end
end
