# frozen_string_literal: true

module Response
  def respond_with(entity: nil, status: 200, serializer: Api::V1::Serializer::Error)
    if entity
      render json: serializer.new(entity).to_json, status: status
    else
      render json: {}, status: status
    end
  end
end
