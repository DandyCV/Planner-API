# frozen_string_literal: true

module Api::V1::Plans::Operation
  class Create < ApplicationOperation
    step :validate_contract
    step :create_plan

    def validate_contract(params)
      contract = Api::V1::Plans::Contract::Create.call(params)
      contract.success? ? Success(params.merge(contract: contract)) : Failure(contract)
    end

    def create_plan(params)
      plan = params[:current_user].plans.create(title: params[:contract].title)
      plan.persisted? ? Success(plan) : Failure(plan.errors)
    end
  end
end
