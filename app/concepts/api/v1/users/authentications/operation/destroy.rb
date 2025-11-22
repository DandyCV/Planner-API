# frozen_string_literal: true

module Api::V1::Users::Authentications::Operation
  class Destroy < ApplicationOperation
    step :destroy_session

    def destroy_session(access_payload)
      Api::V1::Lib::Service::Session.destroy_session(access_payload)
      Success(nil)
    rescue StandardError => error
      Failure({ errors: [{ message: error.message }] })
    end
  end
end
