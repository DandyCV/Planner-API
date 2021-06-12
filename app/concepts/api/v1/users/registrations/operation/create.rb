# frozen_string_literal: true

module Api::V1::Users::Registrations::Operation
  class Create < ApplicationOperation
    # step :validate
    step :create

    # def validate(params)
    #   params[:email] && params[:password] ? Success(params) : Failure({errors: 'wrong credentials'})
    # end

    def create(params)
      user = User.new(email: params[:email], password: params[:password])
      user.save ? Success(user) : Failure({ errors: user.errors })
    end
  end
end
