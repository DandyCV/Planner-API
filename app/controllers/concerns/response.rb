# frozen_string_literal: true

module Response
  def respond_with(entity:, status: 200, serializer: nil)
    object = serializer.new(entity).as_json if serializer
    render json: object, status: status
  end
end
