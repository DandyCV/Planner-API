# frozen_string_literal: true

module Api::V1::Serializer
  class Error
    def initialize(object)
      @object = object
    end

    def to_json(*_args)
      if @object.is_a?(Dry::Validation::Result)
        errors = []
        @object.errors.each do |error|
          errors << {
            source:
            {
              pointer: "/data/attributes/#{error.path.first}"
            },
            detail: error.text
          }
        end
        { errors: errors }.to_json
      else
        @object
      end
    end
  end
end
