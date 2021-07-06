# frozen_string_literal: true

module Api::V1::Users::Registrations::Operation
  class Create < ApplicationOperation
    step :validate_contract
    step :create_user
    step :send_email

    def validate_contract(params)
      contract = Api::V1::Users::Registrations::Contract::Create.call(params)
      contract.success? ? Success(contract) : Failure(contract)
    end

    def create_user(contract)
      Success(User.create(email: contract.email, password: contract.password))
    end

    def send_email(contract)
      # payload = {
      #   id: contract.id,
      #   email: contract.email,
      #   time_stamp: contract.created_at
      # }
      # token = encode(payload)
      # send_an_email(token)
      Success(contract)
    end
  end
end
