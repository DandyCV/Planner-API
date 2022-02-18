# frozen_string_literal: true

module Response
  def respond_with(entity: nil, status: 200, serializer: Api::V1::Serializer::Error, options: nil)
    return head(status) unless entity

    return render json: serializer.new(entity).to_json, status: status unless options

    render json: serializer.new(entity, options).to_json, status: status
  end
end
