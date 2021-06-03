# frozen_string_literal: true

Rails.application.routes.draw do
  scope :api do
    scope :v1, module: :v1 do
      post '/registration', to: 'users#create'
    end
  end
end
