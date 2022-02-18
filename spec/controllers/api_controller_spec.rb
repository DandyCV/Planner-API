# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  it { expect(described_class).to be < ActionController::API }
  it { expect(described_class).to include(Response) }
  it { expect(described_class).to include(JWTSessions::RailsAuthorization) }
end
