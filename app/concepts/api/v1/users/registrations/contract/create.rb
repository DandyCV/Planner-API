# frozen_string_literal: true

module Api::V1::Users::Registrations::Contract
  class Create < ApplicationContract
    params do
      required(:email).filled(:string)
      required(:password).filled(:string, min_size?: Constants::Shared::PASSWORD_MIN_SIZE)
      required(:password_confirmation).filled(:string)
    end

    rule(:email) do
      key.failure(I18n.t('users.registrations.contract.create.email')) unless Truemail.valid?(value)
      key.failure(I18n.t('users.registrations.contract.create.taken')) if !rule_error? && User.exists?(email: value)
    end

    rule(:password_confirmation) do
      key.failure(I18n.t('users.registrations.contract.create.confirmation')) if value != values[:password]
    end
  end
end
