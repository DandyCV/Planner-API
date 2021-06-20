# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Contract::Create, type: :contract do
  subject(:contract) do
    described_class
  end

  let(:result) { contract.call(params) }
  let(:i18n_path) { %i[users registrations contract create] }
  let(:email) { random_email }
  let(:password) { random_password }

  describe 'Success' do
    context 'when valid params' do
      let(:params) { { email: email, password: password, password_confirmation: password } }

      it 'returns valid contract' do
        expect(result.errors).to be_empty
        expect(result).to be_success
      end
    end
  end

  describe 'Failure' do
    describe 'with invalid credentials' do
      context 'when missed required fields' do
        let(:params) { {} }

        it 'return contract with errors' do
          expect_errors(result, %i[email password password_confirmation], 'is missing')
          expect(result).to be_failure
        end
      end

      context 'when required fields are blank' do
        let(:params) { { email: '', password: '', password_confirmation: '' } }

        it 'return contract with errors' do
          expect_errors(result, %i[email password password_confirmation], 'must be filled')
          expect(result).to be_failure
        end
      end

      context 'when required fields has unexpected types' do
        let(:password) { 12_345_678 }
        let(:params) { { email: [random_email], password: password, password_confirmation: password } }

        it 'return contract with errors' do
          expect_errors(result, %i[email password password_confirmation], 'must be a string')
          expect(result).to be_failure
        end
      end
    end

    describe 'When credentials do not satisfy rules' do
      context 'when email has been taken' do
        let(:params) { { email: email, password: password, password_confirmation: password } }

        it 'return contract with errors' do
          allow(User).to receive(:exists?).with(email: email).and_return(true)
          expect_errors(result, %i[email], I18n.t(:taken, scope: i18n_path))
          expect(result).to be_failure
        end
      end

      context 'when password is too short' do
        let(:short_password) { password[0, min_size - 1] }
        let(:params) { { email: email, password: short_password, password_confirmation: short_password } }
        let(:min_size) { Constants::Shared::PASSWORD_MIN_SIZE }

        it 'return contract with errors' do
          expect_errors(result, %i[password], "size cannot be less than #{min_size}")
          expect(result).to be_failure
        end
      end

      context 'when passwords do not match' do
        let(:params) { { email: email, password: password, password_confirmation: '@nother_P@55w0rd' } }

        it 'return contract with errors' do
          expect_errors(result, %i[password_confirmation], I18n.t(:confirmation, scope: i18n_path))
          expect(result).to be_failure
        end
      end

      context 'when email has invalid format' do
        let(:params) { { email: 'this_is@emai!.com', password: password, password_confirmation: password } }

        it 'return contract with errors' do
          expect_errors(result, %i[email], I18n.t(:email, scope: i18n_path))
          expect(result).to be_failure
        end
      end
    end
  end
end
