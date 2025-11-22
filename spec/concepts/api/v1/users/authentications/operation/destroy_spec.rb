# frozen_string_literal: true

RSpec.describe Api::V1::Users::Authentications::Operation::Destroy do
  describe '.call' do
    subject(:operation) { described_class.call(payload) }

    let(:payload) { { 'uid' => SecureRandom.uuid, 'ruid' => SecureRandom.uuid } }

    it 'destroys the session' do
      expect(Api::V1::Lib::Service::Session).to receive(:destroy_session).with(payload)
      expect(operation).to be_success
    end
  end
end
