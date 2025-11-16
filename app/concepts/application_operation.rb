# frozen_string_literal: true

class ApplicationOperation
  include Dry::Transaction

  def self.call(params, &)
    new.call(params, &)
  end
end
