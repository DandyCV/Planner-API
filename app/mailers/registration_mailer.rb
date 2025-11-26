# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  def confirmation_email(email, token, path)
    @email = email
    host = Rails.application.config.action_mailer.default_url_options[:host]
    @confirmation_url = "#{host}/#{path}?email_token=#{token}"
    mail(to: email, subject: I18n.t('user_mailer.confirmation.subject'))
  end
end
