# frozen_string_literal: true

RSpec.describe 'Authentications' do
  let(:password) { random_password }
  let(:user) { create(:user, :confirmed, password: password) }
  let(:params) { { email: user.email, password: password } }
  let(:headers) { { 'Authorization' => "Bearer #{session_tokens[:access]}" } }
  let(:session_tokens) { Api::V1::Lib::Service::Session.create_session(user) }

  before { JWTSessions.encryption_key = 'test123456' }

  describe 'POST /api/v1/users/authentication' do
    before { post '/api/v1/users/authentication', params: params, as: :json }

    describe 'Succes' do
      it 'renders OK' do
        expect(response).to be_created
        expect(response).to match_json_schema('v1/users/authentications/create/create')
      end
    end

    describe 'Failure' do
      describe 'Unathorized' do
        context 'when email is not registered' do
          let(:params) { { email: 'wrong@email.com', password: password } }

          it 'renders incorect user email error' do
            expect(response).to be_unauthorized
            expect(response).to match_json_schema('v1/error/401')
            expect(response.body).to include(I18n.t('users.authentications.operation.create.email'))
          end
        end
      end
    end
  end

  describe 'POST /api/v1/users/authentication/refresh' do
    before do
      session_tokens
      post '/api/v1/users/authentication/refresh', headers: headers
    end

    context 'with valid session' do
      it 'returns new tokens' do
        expect(response).to be_successful
        expect(response).to match_json_schema('v1/users/authentications/refresh/create')
      end
    end

    context 'without token' do
      let(:headers) { {} }

      it 'returns unauthorized error' do
        expect(response).to be_unauthorized
        expect(response).to match_json_schema('v1/error/401')
      end
    end

    context 'when operation fails' do
      let(:error_message) { 'Session refresh failed' }

      before do
        allow(Api::V1::Lib::Service::Session).to receive(:refresh_session).and_raise(StandardError, error_message)
      end

      it 'returns unauthorized error' do
        post '/api/v1/users/authentication/refresh', headers: headers
        expect(response).to be_unauthorized
        expect(response).to match_json_schema('v1/error/401')
      end
    end
  end

  describe 'DELETE /api/v1/users/authentication' do
    before { session_tokens }

    it 'destroys the session' do
      delete '/api/v1/users/authentication', headers: headers
      expect(response).to have_http_status(:no_content)

      post '/api/v1/users/authentication/refresh', headers: headers
      expect(response).to be_unauthorized
      expect(response).to match_json_schema('v1/error/401')
    end

    context 'when operation fails' do
      let(:error_message) { 'Session destroy failed' }

      before do
        allow(Api::V1::Lib::Service::Session).to receive(:destroy_session).and_raise(StandardError, error_message)
      end

      it 'returns unauthorized error' do
        delete '/api/v1/users/authentication', headers: headers
        expect(response).to be_unauthorized
        expect(response).to match_json_schema('v1/error/401')
      end
    end
  end
end
