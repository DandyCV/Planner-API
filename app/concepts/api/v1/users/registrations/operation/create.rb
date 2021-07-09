# frozen_string_literal: true

module Api::V1::Users::Registrations::Operation
  class Create < ApplicationOperation
    step :validate_contract
    step :create_user
    step :create_email_token
    step :send_email

    def validate_contract(params)
      contract = Api::V1::Users::Registrations::Contract::Create.call(params)
      contract.success? ? Success(contract) : Failure(contract)
    end

    def create_user(contract)
      Success({ user: User.create(email: contract.email, password: contract.password) })
    end

    def create_email_token(ctx)
      user = ctx[:user]
      Success(
        ctx.merge(
          email_token: Api::V1::Lib::Service::EmailToken.encode(
            id: user.id,
            email: user.email,
            created_at: user.created_at
          )
        )
      )
    end

    def send_email(ctx)
      # Api::V1::Lib::Service::Mailer.send_email(ctx[:email_token])
      Success(ctx[:user])
    end
  end
end
