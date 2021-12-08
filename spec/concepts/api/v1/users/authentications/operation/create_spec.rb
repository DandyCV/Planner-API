# frozen_string_literal: true

RSpec.describe Api::V1::Users::Authentications::Operation::Create do
  describe '.call' do
    subject(:operation) { described_class.call(params) }

    let(:email) { random_email }
    let(:password) { random_password }
    let!(:user) { create(:user, :confirmed, email: email, password: password) }
    let(:params) { { email: email, password: password } }
    let(:payload) { { user_id: user.id } }

    before { JWTSessions.encryption_key = 'test123456' }

    describe 'Success' do
      context 'when all steps pass' do
        let(:contract_class) { Api::V1::Users::Authentications::Contract::Create }

        it 'finds the user' do
          expect(User).to receive(:find_by).with(email: params[:email]).and_return(user)
          operation
        end

        it 'authenticates the user' do
          expect_any_instance_of(user.class).to receive(:authenticate).with(params[:password])
          operation
        end

        it 'validates the user' do
          expect_any_instance_of(user.class).to receive(:confirmed?)
          operation
        end

        it 'creates session' do
          expect(JWTSessions::Session).to receive(:new).with(payload: payload).and_call_original
          operation
        end
      end

      it 'returns saved session' do
        expect(operation.success).to include(:csrf, :access, :access_expires_at, :refresh, :refresh_expires_at)
        expect(operation).to be_success
        operation
      end
    end

    describe 'Failure' do
      context 'when user with wrong email' do
        let(:errors) { operation.failure[:errors] }
        let(:params) { { email: 'wrong@email.com', password: password } }

        it 'returns errors' do
          expect(errors).to include({ email: I18n.t('users.authentications.operation.create.email') })
          expect(errors).not_to be_empty
          expect(operation).to be_failure
        end
      end
    end

    context 'when user with wrong password' do
      let(:errors) { operation.failure[:errors] }
      let(:params) { { email: email, password: 'wrong_password!' } }

      it 'returns errors' do
        expect(errors).to include({ password: I18n.t('users.authentications.operation.create.password') })
        expect(errors).not_to be_empty
        expect(operation).to be_failure
      end
    end

    context 'when user is not confirmed' do
      let(:errors) { operation.failure[:errors] }
      let(:params) { { email: email, password: password } }

      before do
        user.confirmed = false
        user.save
      end

      it 'returns errors' do
        expect(errors).to include({ email: I18n.t('users.authentications.operation.create.confirmation') })
        expect(errors).not_to be_empty
        expect(operation).to be_failure
      end
    end
  end
end
