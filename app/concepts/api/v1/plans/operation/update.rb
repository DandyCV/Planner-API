# frozen_string_literal: true

module Api::V1::Plans::Operation
  class Update < ApplicationOperation
    step :find_plan
    step :validate_contract
    step :update_plan

    def find_plan(params)
      plan = params[:current_user].plans.find_by(id: params[:id])
      if plan
        Success(params.merge(plan: plan))
      else
        Failure({ errors: [{ message: I18n.t('plans.operation.not_found') }] })
      end
    end

    def validate_contract(params)
      contract = Api::V1::Plans::Contract::Create.call(params)
      contract.success? ? Success(params.merge(contract: contract)) : Failure(contract)
    end

    def update_plan(params)
      plan = params[:plan]
      contract = params[:contract]
      plan.update(title: contract.title)
      Success(plan)
    end
  end
end
