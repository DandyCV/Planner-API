# frozen_string_literal: true

module Api::V1::Users::Confirmation::Serializer
  class Create < ApplicationSerializer
    set_type :user
    attributes :id, :email, :confirmed
  end
end
