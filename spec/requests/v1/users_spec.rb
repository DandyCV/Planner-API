# frozen_string_literal: true

RSpec.describe 'Registrations', type: :request do
  let(:email) { random_email }
  let(:password) { random_password }
  let(:params) { { email: email, password: password, password_confirmation: password } }

  describe 'POST /api/v1/users/registration' do
    before { post '/api/v1/users/registration', params: params, as: :json }

    describe 'Succes' do
      it 'renders user' do
        expect(response).to be_created
        expect(response).to match_json_schema('v1/users/registrations/create/create')
      end
    end

    describe 'Failure' do
      describe 'Unprocessable Entity' do
        context 'when emaile has been taken' do
          before { post '/api/v1/users/registration', params: params, as: :json }

          it 'response 422' do
            expect(response).to be_unprocessable
            expect(response).to match_json_schema('v1/error/422')
          end
        end
      end
    end
  end
end
