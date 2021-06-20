# frozen_string_literal: true

module Api::V1::Serializer
  class Error
    def initialize(object)
      @object = object
    end

    def to_json(*_args)
      @object.respond_to?(:errors) ? { data: @object.to_h, errors: @object.errors.to_h } : @object
    end
  end
end
