# frozen_string_literal: true

module Api::V1::Users::Registrations::Operation
  class Create < ApplicationOperation
    step :validate_contract
    step :create_user

    private

    def validate_contract(params)
      contract = Api::V1::Users::Registrations::Contract::Create.call(params)
      contract.success? ? Success(contract) : Failure(contract)
    end

    def create_user(contract)
      Success(User.create(email: contract.email, password: contract.password))
    end
  end
end
