# frozen_string_literal: true

module Api::V1::Lib::Service::TokenValidator
  class << self
    def decode(token)
      data = Api::V1::Lib::Service::EmailToken.decode(token)
    rescue JWT::VerificationError
      { errors: [{ token: I18n.t('users.confirmations.token.invalid') }] }
    else
      data.first
    end

    def user_validation(data)
      user = User.find_by(
        id: data[:id],
        email: data[:email],
        created_at: data[:created_at]
      )
      user ? token_period(user) : { errors: [{ token: I18n.t('users.confirmations.token.data') }] }
    end

    private

    def token_period(user)
      if (DateTime.now - Constants::Shared::VALID_TOKEN_TIME) < user.created_at
        user
      else
        { errors: [{ token: I18n.t('users.confirmations.token.expired') }] }
      end
    end
  end
end
