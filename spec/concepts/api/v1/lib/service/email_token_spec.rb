# frozen_string_literal: true

RSpec.describe Api::V1::Lib::Service::EmailToken do
  let(:payload) { { params: 42 } }
  let(:hmac_secret) { 'hmac_secret' }
  let(:hmac) { 'hmac' }

  before do
    stub_const("#{described_class}::HMAC_SECRET", hmac_secret)
    stub_const("#{described_class}::HMAC", hmac)
  end

  it { expect(defined?(described_class::HMAC_SECRET)).to eq('constant') }
  it { expect(defined?(described_class::HMAC)).to eq('constant') }

  describe '#encode' do
    it 'creates email token' do
      expect(JWT).to receive(:encode).with(payload, hmac_secret, hmac)
      described_class.encode(payload)
    end
  end

  describe '#decode' do
    it 'decodes email token' do
      expect(JWT).to receive(:decode).with(payload, hmac_secret, true, { algorithm: hmac })
      described_class.decode(payload)
    end
  end
end
