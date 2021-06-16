# frozen_string_literal: true

module Api::V1::Users::Registrations::Contract
  class Create < ApplicationContract
    PASSWORD_MIN_SIZE = 6
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    def call(params)
      params = params.permit!.to_h if params.is_a?(ActionController::Parameters)
      super
    end

    params do
      required(:email).filled(:string, format?: VALID_EMAIL_REGEX)
      required(:password).filled(:string, min_size?: PASSWORD_MIN_SIZE)
      required(:password_confirmation).filled(:string)
    end

    rule(:email) do
      key.failure(I18n.t('users.registrations.contract.create.taken')) if User.exists?(email: value)
    end

    rule(:password_confirmation) do
      key.failure(I18n.t('users.registrations.contract.create.confirmation')) if value != values[:password]
    end
  end
end
