# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  it { expect(described_class).to be < ActionController::API }
end
