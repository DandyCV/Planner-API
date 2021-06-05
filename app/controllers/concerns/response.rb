# frozen_string_literal: true

module Response
  def respond_with(params)
    serializer = params[:serializer]
    object = serializer.new(params[:entity]).as_json if params[:serializer]
    render json: object, status: params[:status]
  end
end
