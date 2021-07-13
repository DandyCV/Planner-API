# frozen_string_literal: true

module Api::V1::Users
  class ConfirmationsController < ApiController
    def index
      Api::V1::Users::Confirmations::Operation::Index.call(params) do |result|
        result.success do |user|
          respond_with(
            status: 200,
            entity: user,
            serializer: Api::V1::Users::Confirmations::Serializer::Index
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
