# frozen_string_literal: true

module Api::V1::Users
  class AuthenticationsController < ApiController
    skip_before_action :authorize_access_session, only: %i[create refresh]
    before_action :authorize_refresh_session, only: :refresh

    def create
      Api::V1::Users::Authentications::Operation::Create.call(params) do |result|
        result.success do |data|
          respond_with(
            status: 201,
            entity: data[:user],
            serializer: Api::V1::Users::Authentications::Serializer::Create,
            options: { meta: data[:session] }
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

    def refresh
      Api::V1::Users::Authentications::Operation::Refresh.call(payload) do |result|
        result.success do |tokens|
          respond_with(
            entity: tokens,
            serializer: Api::V1::Users::Authentications::Serializer::Refresh
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

    def destroy
      Api::V1::Users::Authentications::Operation::Destroy.call(payload) do |result|
        result.success do
          respond_with(status: 204)
        end

        result.failure do |failure_object|
          respond_with(
            status: 401,
            entity: failure_object
          )
        end
      end
    end

    private

    def authorize_refresh_session
      authorize_refresh_by_access_request!
    end
  end
end
