# frozen_string_literal: true

RSpec.describe ApplicationMailer, type: :mailer do
  it { expect(described_class).to be < ActionMailer::Base }
  it { expect(described_class.default[:from]).to eq(Constants::Shared::EMAIL_ADDRESS) }
  it { expect(described_class._layout).to eq('mailer') }
end
