# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Operation::Create do
  describe '.call' do
    subject(:operation) { described_class.call(params) }

    let(:email) { random_email }
    let(:password) { random_password }
    let(:params) { { email: email, password: password, password_confirmation: password } }

    describe 'Success' do
      it 'generates email token' do
        expect(Api::V1::Lib::Service::EmailToken).to receive(:encode)
        operation
      end

      it 'mailer creates a new job' do
        expect { operation }.to have_enqueued_job
      end

      it 'returns saved user' do
        expect { operation }.to change(User, :count).from(0).to(1)
        expect(operation.success).to be_an_instance_of(User)
        expect(operation).to be_success
        operation
      end
    end

    describe 'Failure' do
      context 'when user with invalid params' do
        let(:params) { '42' }

        it 'returns errors' do
          expect { operation }.not_to change(User, :count)
          expect(operation.failure).to be_an_instance_of(Dry::Validation::Result)
          expect(operation.failure.errors).not_to be_empty
          expect(operation).to be_failure
        end
      end
    end
  end
end
