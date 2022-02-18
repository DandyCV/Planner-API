# frozen_string_literal: true

module Api::V1::Lib::Service::Session
  class << self
    def create_session(auth_user)
      payload = { user_id: auth_user.id }
      session = JWTSessions::Session.new(payload: payload)
      session.login
    end
  end
end
