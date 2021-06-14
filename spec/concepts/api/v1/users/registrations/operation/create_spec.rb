# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Operation::Create do
  describe '.call' do
    subject(:operation) { described_class.call(params) }

    let(:user) { build(:user) }
    let(:params) { { email: user.email, password: user.password, password_confirmation: user.password } }

    describe 'Success' do
      it 'returns saved user' do
        expect { operation }.to change(User, :count).from(0).to(1)
        expect(operation).to be_success
        expect(operation.success).to be_an_instance_of(User)
      end
    end

    describe 'Failure' do
      context 'when user with invalid params' do
        let(:params) { '42' }

        it 'returns errors' do
          expect { operation }.not_to change(User, :count)
          expect(operation).to be_failure
          expect(operation.failure.errors).not_to be_empty
        end
      end
    end
  end
end
