# frozen_string_literal: true

module Api::V1::Users::Registrations::Contract
  class Validate < ApplicationContract
    params do
      required(:email).filled(:string)
      required(:password).filled(:string)
    end

    rule(:email) do
      key.failure('has allready been taken') if User.exists?(email: value)
    end
  end
end
