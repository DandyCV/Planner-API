# frozen_string_literal: true

module V1
  class RegistrationsController < ApiController
    def create
      user = User.new(params.permit(:email, :password))
      # render json: user, status: :created if user.save
      if user.save
        respond_with(status: 201, entity: user, serializer: RigistrationSerializer)
      else
        respond_with(status: 422, entity: 'error')
      end

      # Api::V1::Users::Registrations::Operation::Create.call(params) do |result|
      #   result.success do |post|
      #     respond_with(status: 201, entity: post, serializer: Serializers::Post)
      #   end

      #   result.failure do |contract|
      #     respond_with(status: 422, entity: contract, serializer: Serializers::JsonApi::ResourceError)
      #   end
    end
  end
end
