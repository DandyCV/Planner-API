# frozen_string_literal: true

module Api::V1
  class PlansController < ApiController
    def index
      plans = current_user.plans.order(created_at: :desc)
      respond_with(
        status: 200,
        entity: plans,
        serializer: Api::V1::Plans::Serializer::Show
      )
    end

    def show
      Api::V1::Plans::Operation::Show.call(params, current_user: current_user) do |result|
        result.success do |plan|
          respond_with(
            status: 200,
            entity: plan,
            serializer: Api::V1::Plans::Serializer::Show
          )
        end

        result.failure do |failure_object|
          respond_with(
            status: 404,
            entity: failure_object
          )
        end
      end
    end

    def create
      Api::V1::Plans::Operation::Create.call(params, current_user: current_user) do |result|
        result.success do |plan|
          respond_with(
            status: 201,
            entity: plan,
            serializer: Api::V1::Plans::Serializer::Show
          )
        end

        result.failure do |failure_object|
          respond_with(
            status: 422,
            entity: failure_object
          )
        end
      end
    end

    def update
      Api::V1::Plans::Operation::Update.call(params, current_user: current_user) do |result|
        result.success do |plan|
          respond_with(
            status: 200,
            entity: plan,
            serializer: Api::V1::Plans::Serializer::Show
          )
        end

        result.failure do |failure_object|
          status = failure_object.is_a?(Hash) ? 404 : 422
          respond_with(
            status: status,
            entity: failure_object
          )
        end
      end
    end

    def destroy
      Api::V1::Plans::Operation::Destroy.call(params, current_user: current_user) do |result|
        result.success do
          respond_with(status: 204)
        end

        result.failure do |failure_object|
          respond_with(
            status: 404,
            entity: failure_object
          )
        end
      end
    end
  end
end
