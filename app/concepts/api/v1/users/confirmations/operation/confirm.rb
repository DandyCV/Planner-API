# frozen_string_literal: true

module Api::V1::Users::Confirmations::Operation
  class Confirm < ApplicationOperation
    step :decode_token
    step :validate_user
    step :validate_token
    step :update_user

    def decode_token(params)
      data = Api::V1::Lib::Service::EmailToken.decode(params[:token])
    rescue JWT::VerificationError
      Failure({ errors: [{ token: I18n.t('users.confirmations.token.invalid') }] })
    else
      Success(data.first)
    end

    def validate_user(data)
      user = User.find_by(
        id: data[:id],
        email: data[:email],
        created_at: data[:created_at]
      )
      user ? Success(user) : Failure({ errors: [{ token: I18n.t('users.confirmations.token.data') }] })
    end

    def validate_token(user)
      if (DateTime.now - Constants::Shared::VALID_TOKEN_TIME) < user.created_at
        Success(user)
      else
        Failure({ errors: [{ token: I18n.t('users.confirmations.token.expired') }] })
      end
    end

    def update_user(user)
      Success(user.update(confirmed: true))
    end
  end
end
