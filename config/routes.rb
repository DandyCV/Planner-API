# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
        resource :confirmation, only: :show
        resource :registration, only: :create
      end
    end
  end
end
