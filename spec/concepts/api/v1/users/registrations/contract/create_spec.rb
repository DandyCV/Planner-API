# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Contract::Create, type: :contract do
  subject(:contract) do
    described_class
  end

  let(:result) { contract.call(params) }
  let(:i18n_path) { %i[users registrations contract create] }

  describe 'Success' do
    context 'when valid params' do
      let(:user) { build(:user) }
      let(:params) { { email: user.email, password: user.password, password_confirmation: user.password } }

      it 'returns valid object' do
        expect(result).to be_success
        expect(result.errors).to be_empty
      end
    end
  end

  describe 'Failure' do
    describe 'With invalid credentials' do
      context 'when missed required fields' do
        let(:params) { {} }

        it 'return object with errors' do
          expect(result).to be_failure
          expect_errors(result, %i[email password password_confirmation], 'is missing')
        end
      end

      context 'when required fields are blank' do
        let(:params) { { email: '', password: '', password_confirmation: '' } }

        it 'return object with errors' do
          expect(result).to be_failure
          expect_errors(result, %i[email password password_confirmation], 'must be filled')
        end
      end

      context 'when required fields has unexpected types' do
        let(:password) { 12_345_678 }
        let(:params) { { email: [random_email], password: password, password_confirmation: password } }

        it 'return object with errors' do
          expect(result).to be_failure
          expect_errors(result, %i[email password password_confirmation], 'must be a string')
        end
      end
    end

    describe 'When credentials do not satisfy rules' do
      let(:user) { build(:user) }

      context 'when email has been taken' do
        let(:params) { { email: user.email, password: user.password, password_confirmation: user.password } }

        it 'return object with errors' do
          allow(User).to receive(:exists?).with(email: user.email).and_return(true)
          expect(result).to be_failure
          expect_errors(result, [:email], I18n.t(:taken, scope: i18n_path))
        end
      end

      context 'when password is too short' do
        let(:password) { user.password[0, min_size - 1] }
        let(:params) { { email: user.email, password: password, password_confirmation: password } }
        let(:min_size) { Constants::Shared::PASSWORD_MIN_SIZE }

        it 'return object with errors' do
          expect(result).to be_failure
          expect_errors(result, [:password], "size cannot be less than #{min_size}")
        end
      end

      context 'when passwords do not match' do
        let(:params) { { email: user.email, password: user.password, password_confirmation: '@nother_P@55w0rd' } }

        it 'return object with errors' do
          expect(result).to be_failure
          expect_errors(result, [:password_confirmation], I18n.t(:confirmation, scope: i18n_path))
        end
      end

      context 'when email has invalid format' do
        let(:params) { { email: 'this_is@emai!.com', password: user.password, password_confirmation: user.password } }

        it 'return object with errors' do
          expect(result).to be_failure
          expect_errors(result, [:email], I18n.t(:email, scope: i18n_path))
        end
      end
    end
  end
end
