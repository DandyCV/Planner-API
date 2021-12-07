# frozen_string_literal: true

module Response
  def respond_with(entity: nil, status: 200, serializer: Api::V1::Serializer::Error)
    return head(status) unless entity

    render json: serializer.new(entity).to_json, status: status
  end
end
