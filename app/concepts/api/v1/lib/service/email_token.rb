# frozen_string_literal: true

module Api::V1::Lib::Service::EmailToken
  HMAC_SECRET = "test123456"
  HMAC = 'HS256'

  class << self
    def encode(payload)
      JWT.encode(payload, HMAC_SECRET, HMAC)
    end

    def decode(email_token)
      puts "SECRET = #{Rails.application.credentials.secret_key_base}"
      JWT.decode(email_token, HMAC_SECRET, true, { algorithm: HMAC })
    end
  end
end
