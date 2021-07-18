# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  def confirmation_email(email, token, path)
    @email = email
    @confiramtion_url = URI.parse("#{path}?email_token=#{token}").to_s
    mail(to: email, subject: I18n.t('user_mailer.confirmation.subject'))
  end
end
