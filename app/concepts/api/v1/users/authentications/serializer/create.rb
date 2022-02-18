# frozen_string_literal: true

module Api::V1::Users::Authentications::Serializer
  class Create < ApplicationSerializer
    set_type :user
    attributes :email, :created_at
  end
end
