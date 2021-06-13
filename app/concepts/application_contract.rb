# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  config.messages.default_locale = :en

  def self.call(params, &block)
    new.call(params, &block)
  end
end
