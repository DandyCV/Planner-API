# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Contract::Create do
  subject(:contract) do
    described_class
  end

  let(:result) { contract.call(params) }
  let(:scope) { %i[users registrations contract create] }

  describe 'Success' do
    context 'when valid params' do
      let(:user) { build(:user) }
      let(:params) { { email: user.email, password: user.password, password_confirmation: user.password } }

      it 'validates without errors' do
        expect(result).to be_success
        expect(result.errors).to be_empty
      end
    end
  end

  describe 'Failure' do
    describe 'With invalid credentials' do
      context 'when missed required fields' do
        let(:params) { {} }

        it 'validates presence of the required keys' do
          expect(result).to be_failure
          expect(result.errors[:email]).to include('is missing')
          expect(result.errors[:password]).to include('is missing')
          expect(result.errors[:password_confirmation]).to include('is missing')
        end
      end

      context 'when required fields are blank' do
        let(:params) { { email: '', password: '', password_confirmation: '' } }

        it 'validates presence of the required fields' do
          expect(result).to be_failure
          expect(result.errors[:email]).to include('must be filled')
          expect(result.errors[:password]).to include('must be filled')
          expect(result.errors[:password_confirmation]).to include('must be filled')
        end
      end

      context 'when required fields has unexpected types' do
        let(:password) { 12_345_678 }
        let(:params) { { email: [random_email], password: password, password_confirmation: password } }

        it 'validates that required fields have expected types' do
          expect(result).to be_failure
          expect(result.errors[:email]).to include('must be a string')
          expect(result.errors[:password]).to include('must be a string')
          expect(result.errors[:password_confirmation]).to include('must be a string')
        end
      end
    end

    describe 'When credentials do not satisfy rules' do
      let(:user) { build(:user) }

      context 'when email has been taken' do
        let(:params) { { email: user.email, password: user.password, password_confirmation: user.password } }

        it 'validates uniqueness of the email' do
          allow(User).to receive(:exists?).with(email: user.email).and_return(true)
          expect(result).to be_failure
          expect(result.errors[:email]).to include(I18n.t(:taken, scope: scope))
        end
      end

      context 'when password is too short' do
        let(:password) { user.password[0, 5] }
        let(:params) { { email: user.email, password: password, password_confirmation: password } }
        let(:min_size) { Api::V1::Users::Registrations::Contract::Create::PASSWORD_MIN_SIZE.to_s }

        it 'validates that password lenth is enough' do
          expect(result).to be_failure
          expect(result.errors[:password]).to include("size cannot be less than #{min_size}")
        end
      end

      context 'when passwords do not match' do
        let(:params) { { email: user.email, password: user.password, password_confirmation: '@nother_P@55w0rd' } }

        it 'validates that passwords are the same' do
          expect(result).to be_failure
          expect(result.errors.to_h[:password_confirmation]).to include(I18n.t(:confirmation, scope: scope))
        end
      end

      context 'when email has invalid format' do
        let(:params) { { email: 'this_is@emai!.com', password: user.password, password_confirmation: user.password } }

        it 'validates email to have valid address' do
          expect(result).to be_failure
          expect(result.errors.to_h[:email]).to include(I18n.t(:email, scope: scope))
        end
      end
    end
  end
end
