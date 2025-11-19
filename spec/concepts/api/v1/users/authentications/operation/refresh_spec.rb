# frozen_string_literal: true

RSpec.describe Api::V1::Users::Authentications::Operation::Refresh do
  describe '.call' do
    subject(:operation) { described_class.call(payload) }

    let(:payload) { { 'uid' => SecureRandom.uuid, 'ruid' => SecureRandom.uuid } }
    let(:tokens) { { access: 'new', csrf: 'csrf-token' } }

    it 'returns refreshed tokens' do
      expect(Api::V1::Lib::Service::Session).to receive(:refresh_session).with(payload).and_return(tokens)
      expect(operation.success).to eq(tokens)
      expect(operation).to be_success
    end
  end
end
