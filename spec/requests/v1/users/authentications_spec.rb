# frozen_string_literal: true

RSpec.describe 'Authentications', type: :request do
  let(:password) { random_password }
  let(:user) { create(:user, :confirmed, password: password) }
  let(:params) { { email: user.email, password: password } }

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
end
