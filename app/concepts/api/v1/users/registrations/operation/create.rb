# frozen_string_literal: true

module Api::V1::Users::Registrations::Operation
  class Create < ApplicationOperation
    step :validate
    step :create

    private

    def validate(params)
      result = Api::V1::Users::Registrations::Contract::Create.call(params)
      result.errors.empty? ? Success(params) : Failure(result)
    end

    def create(params)
      Success(User.create(email: params[:email], password: params[:password]))
    end
  end
end
