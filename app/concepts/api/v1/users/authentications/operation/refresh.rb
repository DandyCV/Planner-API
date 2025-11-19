# frozen_string_literal: true

module Api::V1::Users::Authentications::Operation
  class Refresh < ApplicationOperation
    step :refresh_tokens

    def refresh_tokens(access_payload)
      tokens = Api::V1::Lib::Service::Session.refresh_session(access_payload)
      Success(tokens)
    rescue StandardError => error
      Failure({ errors: [{ message: error.message }] })
    end
  end
end
