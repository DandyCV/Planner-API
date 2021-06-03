# frozen_string_literal: true

module V1
    class V1::UsersController < ApplicationController
        def create
            @user = User.new(params.permit(:email, :password))
            if @user.save
                render json: @user, status: :created
            end
        end
    end
end
