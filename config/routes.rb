# frozen_string_literal: true

Rails.application.routes.draw do
  scope '/api' do
    namespace :v1 do
      scope '/users' do
        resource :registration, only: [:create]
      end
    end
  end
end
