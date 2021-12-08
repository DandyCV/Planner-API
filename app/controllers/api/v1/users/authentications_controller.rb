# frozen_string_literal: true

module Api::V1::Users
  class AuthenticationsController < ApiController
    def create
      Api::V1::Users::Authentications::Operation::Create.call(params) do |result|
        result.success do |session|
          respond_with(
            status: 201,
            entity: session,
            serializer: Api::V1::Serializer::Object
          )
        end

        result.failure do |failure_object|
          respond_with(
            status: 401,
            entity: failure_object
          )
        end
      end
    end
  end
end
