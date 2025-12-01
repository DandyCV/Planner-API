# frozen_string_literal: true

module Api::V1
  class HealthchecksController < ApiController
    skip_before_action :authorize_access_session

    def show
      render json: {
        data: {
          type: 'healthcheck',
          attributes: {
            status: 'ok',
            timestamp: Time.current
          }
        }
      }, status: :ok
    end
  end
end

