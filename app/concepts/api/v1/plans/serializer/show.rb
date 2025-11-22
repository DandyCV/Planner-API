# frozen_string_literal: true

module Api::V1::Plans::Serializer
  class Show < ApplicationSerializer
    set_type :plan
    attributes :id, :title, :created_at, :updated_at
  end
end
