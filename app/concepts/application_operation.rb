# frozen_string_literal: true

class ApplicationOperation
  include Dry::Transaction

  def self.call(params, **kwargs, &)
    new.call(params.merge(kwargs), &)
  end
end
