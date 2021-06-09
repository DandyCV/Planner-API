# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe '.create' do
    let(:user) { described_class.create(email: 'test@email.com', password: 'test1234') }

    it 'creates valid user' do
      expect(user).to be_valid
    end

    it 'dones not allow blank email' do
      user.email = nil
      user.save
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'dones not allow blank password' do
      user.password = nil
      user.save
      expect(user.errors[:password]).to include("can't be blank")
    end

    it 'dones not allow users with same emails' do
      user.save
      user_with_same_email = described_class.create(email: 'test@email.com', password: 'test2345')
      expect(user_with_same_email.errors[:email]).to include('has already been taken')
    end
  end
end
