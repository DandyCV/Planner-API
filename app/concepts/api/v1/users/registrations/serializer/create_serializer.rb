# frozen_string_literal: true

module Api::V1::Users::Registrations::Serializer
  class CreateSerializer < ApplicationSerializer
    attributes :id, :email, :created_at
  end
end
