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
        expect(JSON.parse(response.body)).to be_empty
        expect(User.find(user.id)).to be_confirmed
      end
    end

    describe 'Failure' do
      describe 'Unprocessable Entity' do
        before { get "/api/v1/users/confirmation?email_token=#{email_token}", as: :json }

        context 'when token can not be processed' do
          let(:email_token) { 'this.is.token' }

          it 'renders invalid token error' do
            expect(response).to be_unprocessable
            expect(response).to match_json_schema('v1/error/422')
            expect(response.body).to include(I18n.t('users.confirmations.token.invalid'))
          end
        end

        context 'when token is outdated' do
          let(:user_data) do
            {
              id: user.id,
              email: user.email,
              created_at: user.created_at - Constants::Shared::VALID_TOKEN_TIME - 1.hour
            }
          end

          it 'renders expired token error' do
            expect(response).to be_unprocessable
            expect(response).to match_json_schema('v1/error/422')
            expect(response.body).to include(I18n.t('users.confirmations.token.expired'))
          end
        end

        context 'when token contain not valid user' do
          let(:user_data) do
            {
              id: user.id + 1,
              email: user.email,
              created_at: user.created_at
            }
          end

          it 'renders invalid user data error' do
            expect(response).to be_unprocessable
            expect(response).to match_json_schema('v1/error/422')
            expect(response.body).to include(I18n.t('users.confirmations.token.data'))
          end
        end
      end
    end
  end
end
