# frozen_string_literal: true

module Api::V1::Users::Authentications::Serializer
  class Refresh
    def initialize(tokens)
      @tokens = tokens
    end

    def to_json(*)
      { meta: @tokens }.to_json
    end
  end
end
