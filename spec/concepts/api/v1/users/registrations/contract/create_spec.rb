# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Contract::Create do
  subject(:contract) do
    described_class
  end

  let(:result) { contract.call(params) }

  describe 'User with invalid credentials' do
    context 'when missed required fields' do
      let(:params) { {} }

      it 'validates presence of the required keys' do
        expect(result.errors.to_h[:email]).to include('is missing')
        expect(result.errors.to_h[:password]).to include('is missing')
        expect(result.errors.to_h[:password_confirmation]).to include('is missing')
      end
    end

    context 'when required fields are blank' do
      let(:params) { { email: '', password: '', password_confirmation: '' } }

      it 'validates presence of the required fields' do
        expect(result.errors.to_h[:email]).to include('must be filled')
        expect(result.errors.to_h[:password]).to include('must be filled')
        expect(result.errors.to_h[:password_confirmation]).to include('must be filled')
      end
    end

    context 'when required fields has unexpected types' do
      let(:password) { 12_345_678 }
      let(:params) { { email: [random_email], password: password, password_confirmation: password } }

      it 'validates that required fields have expected types' do
        expect(result.errors.to_h[:email]).to include('must be a string')
        expect(result.errors.to_h[:password]).to include('must be a string')
        expect(result.errors.to_h[:password_confirmation]).to include('must be a string')
      end
    end
  end

  describe 'User can not be saved' do
    let(:user) { build(:user) }

    context 'when email has been taken' do
      let(:params) { { email: user.email, password: user.password, password_confirmation: user.password } }

      before { user.save }

      it 'validates uniqueness of the email' do
        expect { result }.not_to change(User, :count)
        expect(result.errors.to_h[:email]).to include(I18n.t('record.errors.messages.taken'))
      end
    end

    context 'when password less than 6 symbols' do
      let(:password) { user.password[0, 5] }
      let(:params) { { email: user.email, password: password, password_confirmation: password } }

      it 'validates that password lenth is enough' do
        expect { result }.not_to change(User, :count)
        expect(result.errors.to_h[:password]).to include(I18n.t('record.errors.messages.password_length'))
      end
    end

    context 'when passwords do not match' do
      let(:params) { { email: user.email, password: user.password, password_confirmation: '@nother_P@55w0rd' } }

      it 'validates that passwords are the same' do
        expect { result }.not_to change(User, :count)
        expect(result.errors.to_h[:password_confirmation]).to include(I18n.t('record.errors.messages.confirmation'))
      end
    end

    context 'when email has invalid format' do
      let(:params) { { email: 'this_is@emai!.com', password: user.password, password_confirmation: user.password } }

      it 'validates email to have valid address' do
        expect { result }.not_to change(User, :count)
        expect(result.errors.to_h[:email]).to include(I18n.t('record.errors.messages.email'))
      end
    end
  end
end
