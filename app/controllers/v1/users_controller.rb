# frozen_string_literal: true

module V1
  class UsersController < ApplicationController
    def create
      user = User.new(params.permit(:email, :password))
      render json: user, status: :created if user.save
    end
  end
end
