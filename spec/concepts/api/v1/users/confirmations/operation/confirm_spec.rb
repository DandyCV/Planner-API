# frozen_string_literal: true

RSpec.describe Api::V1::Users::Confirmations::Operation::Confirm do
  describe '.call' do
    subject(:operation) { described_class.call(params) }

    let(:user) { create(:user) }
    let(:user_data) { { id: user.id, email: user.email, created_at: user.created_at } }
    let(:email_token) { Api::V1::Lib::Service::EmailToken.encode(user_data) }
    let(:params) { { email_token: email_token } }

    describe 'Success' do
      it 'returns updated user' do
        expect(operation.success).to eq(true)
        expect(operation).to be_success
        expect(User.find(user.id)).to be_confirmed
      end
    end

    describe 'Failure' do
      context 'when user with invalid token' do
        let(:email_token) { 'this.is.token' }

        it 'returns errors' do
          expect(operation.failure).to be_an_instance_of(::Hash)
          expect(operation.failure[:errors]).to include({ token: I18n.t('users.confirmations.token.invalid') })
          expect(User.find(user.id)).not_to be_confirmed
          expect(operation).to be_failure
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

        it 'returns errors' do
          expect(operation.failure).to be_an_instance_of(::Hash)
          expect(operation.failure[:errors]).to include({ token: I18n.t('users.confirmations.token.expired') })
          expect(User.find(user.id)).not_to be_confirmed
          expect(operation).to be_failure
        end
      end

      context 'when token contain not valid user data' do
        let(:user_data) do
          {
            id: user.id + 1,
            email: user.email,
            created_at: user.created_at
          }
        end

        it 'returns errors' do
          expect(operation.failure).to be_an_instance_of(::Hash)
          expect(operation.failure[:errors]).to include({ token: I18n.t('users.confirmations.token.data') })
          expect(User.find(user.id)).not_to be_confirmed
          expect(operation).to be_failure
        end
      end
    end
  end
end
