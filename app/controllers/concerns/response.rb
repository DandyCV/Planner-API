# frozen_string_literal: true

module Response
  def respond_with(entity:, status: 200, serializer: nil)
    entity = serializer.new(entity).to_json if serializer
    render json: entity, status: status
  end
end
