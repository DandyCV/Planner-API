# frozen_string_literal: true

module Api::V1::Plans::Contract
  class Create < ApplicationContract
    params do
      required(:title).filled(:string)
    end
  end
end
