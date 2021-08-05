# frozen_string_literal: true

module Api::V1::Users::Confirmations::Operation
  class Confirm < ApplicationOperation
    step :decode_token
    step :validate_data
    step :update_user

    def decode_token(params)
      data = Api::V1::Lib::Service::TokenValidator.decode(params[:token])
      data[:errors] ? Failure(data[:errors]) : Success(data.first)
    end

    def validate_data(data)
      validated_data = Api::V1::Lib::Service::TokenValidator.user_validation(data)
      validated_data.is_a?(::User) ? Success(validated_data) : Failure(validated_data)
    end

    def update_user(user)
      Success(user.update(confirmed: true))
    end
  end
end
