# frozen_string_literal: true

module Serializers
  class RegistrationSerializer < ApplicationSerializer
    attributes :id, :email, :created_at
  end
end
