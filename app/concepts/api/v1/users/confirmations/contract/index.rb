# frozen_string_literal: true

module Api::V1::Users::Registrations::Contract
  class Create < ApplicationContract
    params do
      required(:email_token).filled(:string, min_size?: Constants::Shared::EMAIL_TOKEN_MIN_SIZE)
      required(:password_confirmation).filled(:string)
    end

    rule(:email_token) do
      unless value.split('.').size == Constants::Shared::EMAIL_TOKEN_BLOCKS_NUMBER
        key.failure(I18n.t('users.confirmations.contract.index.blocks'))
      end
    end
  end
end
