# frozen_string_literal: true

module Api::V1::Plans::Operation
  class Show < ApplicationOperation
    step :find_plan

    def find_plan(params)
      plan = params[:current_user].plans.find_by(id: params[:id])
      plan ? Success(plan) : Failure({ errors: [{ message: I18n.t('plans.operation.not_found') }] })
    end
  end
end
