# frozen_string_literal: true

class ApplicationOperation
  include Dry::Transaction

  def self.call(params, &block)
    params = params.permit!.to_h if params.is_a?(ActionController::Parameters)
    new.call(params, &block)
  end
end
