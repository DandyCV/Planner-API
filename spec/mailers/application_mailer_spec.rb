# frozen_string_literal: true

RSpec.describe ApplicationMailer, type: :mailer do
  it { expect(described_class).to be < ActionMailer::Base }
  it { expect(described_class.default[:from]).to eq(Rails.application.config.default_sender_email) }
  it { expect(described_class._layout).to eq('mailer') }
end
