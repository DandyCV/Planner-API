# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  config.messages.default_locale = :en

  def self.call(params)
    params = params.to_unsafe_hash if params.is_a?((ActionController::Parameters))
    new.call(params).dup.instance_eval do
      values.each { |method, value| define_singleton_method(method) { value } }
      freeze
    end
  end
end
