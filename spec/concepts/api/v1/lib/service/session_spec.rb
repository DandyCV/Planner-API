# frozen_string_literal: true

RSpec.describe Api::V1::Lib::Service::Session do
  let(:auth_user) { create(:user, :confirmed, email: random_email, password: random_password) }
  let(:session) { instance_double('Session', login: login) }
  let(:login) { { access: '42' } }

  describe '#create_session' do
    it 'creates user session' do
      allow(JWTSessions::Session).to receive(:new).with({ payload: { user_id: auth_user.id } }).and_return(session)
      expect(session).to receive(:login).and_return(login)
      described_class.create_session(auth_user)
    end
  end
end
