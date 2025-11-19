# frozen_string_literal: true

RSpec.describe Api::V1::Lib::Service::Session do
  let(:auth_user) { create(:user, :confirmed, email: random_email, password: random_password) }
  let(:login) { { access: '42' } }
  let(:jwt_session) { instance_double(JWTSessions::Session, login: login) }

  describe '.create_session' do
    it 'creates user session with refresh by access enabled' do
      expect(JWTSessions::Session).to receive(:new).with({ payload: { user_id: auth_user.id },
                                                           refresh_by_access_allowed: true }).and_return(jwt_session)
      expect(jwt_session).to receive(:login).and_return(login)
      expect(described_class.create_session(auth_user)).to eq(login)
    end
  end

  describe '.refresh_session' do
    let(:payload) { { 'ruid' => SecureRandom.uuid, 'uid' => SecureRandom.uuid } }
    let(:refreshed_tokens) { { access: 'new', csrf: 'csrf' } }
    let(:refresh_session) { instance_double(JWTSessions::Session, refresh_by_access_payload: refreshed_tokens) }

    it 'refreshes the session by access payload' do
      expect(JWTSessions::Session).to receive(:new).with({ payload: payload }).and_return(refresh_session)
      expect(described_class.refresh_session(payload)).to eq(refreshed_tokens)
    end
  end

  describe '.destroy_session' do
    let(:payload) { { 'ruid' => SecureRandom.uuid, 'uid' => SecureRandom.uuid } }
    let(:destroy_session) { instance_double(JWTSessions::Session, flush_by_access_payload: nil) }

    it 'flushes the session by payload' do
      expect(JWTSessions::Session).to receive(:new).with({ payload: payload }).and_return(destroy_session)
      expect(described_class.destroy_session(payload)).to be_nil
    end
  end
end
