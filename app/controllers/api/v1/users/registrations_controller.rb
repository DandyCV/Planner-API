# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < ApiController
        def create
          user = User.new(params.permit(:email, :password))

          if user.save
            respond_with(
              status: 201,
              entity: user,
              serializer: Api::V1::Users::Registrations::Serializer::CreateSerializer
            )
          else
            respond_with(status: 422, entity: { errors: 'invalid credentials' })
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
  end
end
