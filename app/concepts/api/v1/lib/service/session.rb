# frozen_string_literal: true

module Api::V1::Lib::Service::Session
  class << self
    def create_session(auth_user)
      payload = { user_id: auth_user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
      session.login
    end

    def refresh_session(access_payload)
      session = JWTSessions::Session.new(payload: access_payload)
      session.refresh_by_access_payload
    end

    def destroy_session(access_payload)
      session = JWTSessions::Session.new(payload: access_payload)
      session.flush_by_access_payload
    end
  end
end
