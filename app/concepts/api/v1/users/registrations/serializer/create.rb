# frozen_string_literal: true

module Api::V1::Users::Registrations::Serializer
  class Create < ApplicationSerializer
    set_type :user
    attributes :id, :email, :created_at
  end
end
