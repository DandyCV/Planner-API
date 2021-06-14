# frozen_string_literal: true

module Api::V1::Users::Registrations::Contract
  class Create < ApplicationContract
    VALID_EMAIL_REGEX =
      /(?=\A.{6,255}\z)(\A([\p{L}0-9]+[\w|\-.+]*)@((?i-mx:[\p{L}0-9]+([\-.]{1}[\p{L}0-9]+)*\.\p{L}{2,63}))\z)/

    params do
      required(:email).filled(:string)
      required(:password).filled(:string)
      required(:password_confirmation).filled(:string)
    end

    rule(:email) do
      key.failure(I18n.t('record.errors.messages.taken')) if User.exists?(email: value)
      key.failure(I18n.t('record.errors.messages.email')) unless VALID_EMAIL_REGEX.match?(value)
    end

    rule(:password) do
      key.failure(I18n.t('record.errors.messages.password_length')) if value.length < 6
    end

    rule(:password_confirmation) do
      key.failure(I18n.t('record.errors.messages.confirmation')) if value != values[:password]
    end
  end
end
