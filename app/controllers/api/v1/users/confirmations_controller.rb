# frozen_string_literal: true

module Api::V1::Users
  class ConfirmationsController < ApiController
    skip_before_action :authorize_access_session, only: :show

    def show
      Api::V1::Users::Confirmations::Operation::Show.call(params) do |result|
        result.success do
          respond_with(status: 200)
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
