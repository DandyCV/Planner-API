# frozen_string_literal: true

JWTSessions.algorithm = 'HS256'
JWTSessions.encryption_key = Rails.application.credentials.secret_key_base
JWTSessions.token_store = Rails.env.test? ? :memory : [:redis, {
    redis_host: ENV.fetch('REDIS_HOST', '127.0.0.1'),
    redis_port: ENV.fetch('REDIS_PORT', '6379'),
    redis_db_name: ENV.fetch('REDIS_DB', '0'),
    token_prefix: 'jwt_'
}]
JWTSessions.signing_key = Rails.application.secret_key_base
