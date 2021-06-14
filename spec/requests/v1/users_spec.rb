# frozen_string_literal: true

RSpec.describe 'Registrations', type: :request do
  let(:user) { build(:user) }
  let(:params) { { email: user.email, password: user.password, password_confirmation: user.password } }

  describe 'POST /api/v1/users/registration' do
    context 'when valid request' do
      before do
        post '/api/v1/users/registration', params: params
      end

      it 'renders user' do
        expect(response).to be_created
        # expect(response).to match_json_schema('v1/users/registrations/create')
      end
    end

    context 'when user with the same email' do
      let(:email) { random_email }

      before do
        create(:user, email: email)
        post '/api/v1/users/registration', params: { email: email, password: '123123', password_confirmation: '123123' }
      end

      it 'response 422' do
        expect(response).to have_http_status(:unprocessable_entity)
        # add error schema matching expectation
      end
    end
  end
end
