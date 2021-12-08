# frozen_string_literal: true

module Api::V1::Serializer
  class Object
    def initialize(object)
      @object = object
    end

    def to_json
      {
        data: data
      }.to_json
    end

    private

    def data
      @data ||= { attributes: @object }
    end
  end
end
