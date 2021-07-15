# frozen_string_literal: true

class RegistrationMailer < ApplicationMailer
  def confirmation_email
    user = params[:user]
    @user = user
    @url = "http://#{Rails.application.config.hosts.first}/api/v1/users/confirmation?email_token=#{params[:email_token]}"
    mail(to: user.email, subject: 'Planner-API user registration')
  end
end
