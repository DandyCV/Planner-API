# frozen_string_literal: true

module Api::V1::Users::Confirmation::Operation
  class Index < ApplicationOperation
    step :validate_token
    step :decode_token
    step :validate_data
    step :update_user

    def validate_token(params)
      contract = Api::V1::Users::Confirmation::Contract::Index.call(params)
      contract.success? ? Success(contract) : Failure(contract)
    end

    def decode_token(contract)
      Success(Api::V1::Lib::Service::EmailToken.decode(contract.email_token))
    end

    def validate_data(data)
      contract = Api::V1::Users::Confirmation::Contract::Validate.call(data)
      contract.success? ? Success(contract) : Failure(contract)
    end

    def update_user(contract)
      user = User.find(contract.id)
      Success(user.update(confirmed: true))
    end
  end
end
