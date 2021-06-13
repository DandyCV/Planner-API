# frozen_string_literal: true

RSpec.describe Api::V1::Users::Registrations::Contract::Validate do
  subject(:contract) do
    described_class
  end

  it 'validates presence of the key "email"' do
    result = contract.call({})

    expect(result.errors.to_h[:email]).to include('is missing')
  end

  it 'validates presence of the email' do
    result = contract.call(email: '')

    expect(result.errors.to_h[:email]).to include('must be filled')
  end

  it 'validates presence of the key "password"' do
    result = contract.call({})

    expect(result.errors.to_h[:password]).to include('is missing')
  end

  it 'validates presence of the password' do
    result = contract.call(password: '')

    expect(result.errors.to_h[:password]).to include('must be filled')
  end

  it 'validates uniqueness of the email' do
    params = { email: random_email, password: '12345678' }
    User.create(params)
    result = contract.call(email: params[:email])

    expect(result.errors.to_h[:email]).to include('has allready been taken')
  end
end
