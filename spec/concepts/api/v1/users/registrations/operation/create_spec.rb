# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Operation::Create do
  describe '.call' do
    subject(:operation) { described_class.call(params) }

    describe 'Success' do
      let(:params) { { email: random_email, password: '12345678' } }

      it 'returns saved user' do
        expect { operation }.to change(User, :count).from(0).to(1)
        expect(operation).to be_success
        expect(operation.success).to be_an_instance_of(User)
      end
    end

    describe 'Failure' do
      context 'when user without email' do
        let(:params) { { email: nil, password: '12345678' } }

        it 'returns errors' do
          expect(User.count).to eq(0)
          expect(operation).to be_failure
          expect(operation.failure).to have_key(:errors)
        end
      end

      context 'when user without password' do
        let(:params) { { email: random_email, password: nil } }

        it 'returns errors' do
          expect(User.count).to eq(0)
          expect(operation).to be_failure
          expect(operation.failure).to have_key(:errors)
        end
      end

      context 'when user with taken email' do
        let(:params) { { email: random_email, password: nil } }

        before do
          create(:user, email: params[:email])
        end

        it 'returns errors' do
          expect(User.count).to eq(1)
          expect(operation).to be_failure
          expect(operation.failure).to have_key(:errors)
        end
      end
    end
  end
end
