# frozen_string_literal: true

class ApplicationOperation
  include Dry::Transaction

  def self.call(params, &block)
    new.call(params, &block)
  end
end
