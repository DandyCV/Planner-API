# frozen_string_literal: true

module Helpers
  module ContractHelpers
    module_function

    def expect_errors(entity, keys, message)
      keys.each do |key|
        expect(entity.errors[key]).to eq([message])
      end
    end
  end
end
