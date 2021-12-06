# frozen_string_literal: true

module Api::V1::Lib::Service::EmailToken
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  HMAC = 'HS256'

  class << self
    def encode(payload)
      JWT.encode(payload, HMAC_SECRET, HMAC)
    end

    def decode(email_token)
      JWT.decode(email_token, HMAC_SECRET, true, { algorithm: HMAC })
    end
  end
end
