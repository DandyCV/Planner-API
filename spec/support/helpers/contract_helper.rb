# frozen_string_literal: true

module Helpers
  module ContractHelpers
    module_function

    def expect_errors(entity, keys, message)
      if keys.is_a?(Array)
        keys.each do |key|
          expect(entity.errors[key]).to eq([message])
        end
      else
        expect(entity.errors[keys]).to eq([message])
      end
    end
  end
end
