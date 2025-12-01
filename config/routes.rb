# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'api/v1/healthchecks#show'

  namespace :api do
    namespace :v1 do
      resource :healthcheck, only: :show
      resources :plans, only: %i[index create show update destroy]

      namespace :users do
        resource :authentication, only: %i[create destroy] do
          post :refresh, on: :collection
        end
        resource :confirmation, only: :show
        resource :registration, only: :create
      end
    end
  end
end
