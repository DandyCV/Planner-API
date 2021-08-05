# frozen_string_literal: true

module Api::V1::Users
  class ConfirmationsController < ApiController
    def create
      Api::V1::Users::Confirmations::Operation::Confirm.call(params) do |result|
        result.success do |user|
          respond_with(
            status: 204,
            entity: user,
            serializer: Api::V1::Users::Confirmations::Serializer::Confirm
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
