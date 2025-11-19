# frozen_string_literal: true

module Api::V1::Users
  class RegistrationsController < ApiController
    skip_before_action :authorize_access_session, only: :create

    def create
      Api::V1::Users::Registrations::Operation::Create.call(params) do |result|
        result.success do |user|
          respond_with(
            status: 201,
            entity: user,
            serializer: Api::V1::Users::Registrations::Serializer::Create
          )
        end

        result.failure do |failure_object|
          respond_with(
            status: 422,
            entity: failure_object
          )
        end
      end
    end
  end
end
