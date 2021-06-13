# frozen_string_literal: true

module Api::V1::Users::Registrations::Operation
  class Create < ApplicationOperation
    step :validate
    step :create

    private

    def validate(params)
      result = Api::V1::Users::Registrations::Contract::Validate.call(params)
      result.errors.to_h.empty? ? Success(params) : Failure(result)
    end

    def create(params)
      user = User.new(email: params[:email], password: params[:password])
      begin
        user.save
      rescue StandardError => error
        Failure(error)
      else
        Success(user)
      end
    end
  end
end
