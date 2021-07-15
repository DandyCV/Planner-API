# frozen_string_literal: true

RSpec.describe RegistrationMailer, type: :mailer do
  it { expect(described_class).to be < ApplicationMailer }

  describe '#confirmation email' do
    let(:subject) do
      described_class.with(user: user, email_token: email_token).confirmation_email
    end

    let(:email_token) { 'email_token' }
    let(:user) { build(:user) }
    let(:email_subject) { 'Planner-API user registration' }
    let(:host) { Rails.application.config.hosts.first }
    let(:url) { "http://#{host}/api/v1/users/confirmation?email_token=#{email_token}" }

    it 'renders the headers' do
      expect(subject.subject).to eq(email_subject)
      expect(subject.to).to eq([user.email])
      expect(subject.from).to eq([Constants::Shared::EMAIL_ADDRESS])
    end

    it 'renders the body' do
      expect(subject.body.encoded).to include(user.email)
      expect(subject.body.encoded).to include(url)
    end
  end
end
