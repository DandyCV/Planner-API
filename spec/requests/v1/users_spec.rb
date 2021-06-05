# frozen_string_literal: true

RSpec.describe 'Registrations', type: :request do
  let(:user) { build(:user) }

  describe 'POST /api/v1/users/registration' do
    context 'when valid request' do
      before do
        post '/api/v1/users/registration', params: { email: user.email, password: user.password }
      end

      it 'renders a new user' do
        expect(response).to have_http_status(:created)
      end
    end
  end
end
