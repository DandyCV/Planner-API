# frozen_string_literal: true

module Token
  HMAC_SECRET = Rails.application.credentials.secret_key_base
  ALGO = 'HS256'

  def encode(payload)
    JWT.encode payload, HMAC_SECRET, ALGO
  end

  def decode(token)
    JWT.decode token, HMAC_SECRET, true, { algorithm: ALGO }
  end
end
