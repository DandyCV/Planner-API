# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Constants::Shared::EMAIL_ADDRESS
  layout 'mailer'
end
