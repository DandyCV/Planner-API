# frozen_string_literal: true

module Api::V1::Serializer
  class Error
    def initialize(object)
      @object = object
    end

    def to_json
      { errors: errors }.to_json
    end

    private

    attr_reader :object

    def errors
      if @object.is_a?(::Hash)
        @object[:errors].map do |error|
          {
            source: { pointer: "/data/attributes/#{error.keys.first}" },
            detail: error.values.first
          }
        end
      else
        @errors ||= @object.errors.map do |error|
          {
            source: { pointer: "/data/attributes/#{error.path.first}" },
            detail: error.text
          }
        end
      end
    end
  end
end
