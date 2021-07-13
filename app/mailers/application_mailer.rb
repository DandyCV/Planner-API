# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'planner.api.mailer@gmail.com'
  layout 'mailer'
end
