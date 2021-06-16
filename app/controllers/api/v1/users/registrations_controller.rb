# frozen_string_literal: true

module Api::V1::Users
  class RegistrationsController < ApiController
    def create
      Api::V1::Users::Registrations::Operation::Create.call(params) do |result|
        result.success do |user|
          respond_with(
            status: 201,
            entity: user,
            serializer: Api::V1::Users::Registrations::Serializer::Create
          )
        end

        result.failure do |record|
          respond_with(
            status: 422,
            entity: record.errors
          )
        end
      end
    end
  end
end
