# frozen_string_literal: true

module Response
  def respond_with(entity: nil, status: 200, serializer: nil, params: nil)
    return head(status) unless entity

    if serializer
      render json: serializer.new(entity, { params: params }).to_json, status: status
    else
      render json: Api::V1::Serializer::Error.new(entity).to_json, status: status
    end
  end
end
