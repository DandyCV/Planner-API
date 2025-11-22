# frozen_string_literal: true

module Api::V1::Plans::Operation
  class Destroy < ApplicationOperation
    step :find_plan
    step :destroy_plan

    def find_plan(params)
      plan = params[:current_user].plans.find_by(id: params[:id])
      plan ? Success(params.merge(plan: plan)) : Failure({ errors: [{ message: I18n.t('plans.operation.not_found') }] })
    end

    def destroy_plan(params)
      params[:plan].destroy
      Success(true)
    end
  end
end
