# frozen_string_literal: true

class ApplicationOperation
  include Dry::Transaction
  include Token

  def self.call(params, &block)
    new.call(params, &block)
  end
end
