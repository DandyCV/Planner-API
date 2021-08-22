# frozen_string_literal: true

RSpec.describe 'Confirmations', type: :request do
  let(:user) { create(:user) }
  let(:user_data) { { id: user.id, email: user.email, created_at: user.created_at } }
  let(:email_token) { Api::V1::Lib::Service::EmailToken.encode(user_data) }
  let(:params) { { email_token: email_token } }

  describe 'GET /api/v1/users/confirmation' do
    before { get "/api/v1/users/confirmation?email_token=#{email_token}", as: :json }

    describe 'Succes' do
      it 'renders OK' do
        expect(response).to be_ok
        expect(response.body).to be_empty
      end
    end

    describe 'Failure' do
      describe 'Unprocessable Entity' do
        before { get '/api/v1/users/confirmation', as: :json }

        context 'when request without token' do
          it 'renders invalid token error' do
            expect(response).to be_unprocessable
            expect(response).to match_json_schema('v1/error/422')
            expect(response.body).to include(I18n.t('users.confirmations.token.invalid'))
          end
        end
      end
    end
  end
end
