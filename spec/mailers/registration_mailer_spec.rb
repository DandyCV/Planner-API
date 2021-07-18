# frozen_string_literal: true

RSpec.describe RegistrationMailer, type: :mailer do
  it { expect(described_class).to be < ApplicationMailer }

  describe '#confirmation email' do
    subject(:mailer) { described_class.confirmation_email(email, token, path) }

    let(:email) { random_email }
    let(:token) { random_token }
    let(:path) { random_path }

    it 'includes confirmation data' do
      expect(subject.to).to eq([email])
      expect(subject.from).to eq([Rails.configuration.default_sender_email])
      expect(subject.subject).to eq(I18n.t('user_mailer.confirmation.subject'))
      expect(mailer.body.encoded).to include(URI.parse("#{path}?email_token=#{token}").to_s)
    end
  end
end
