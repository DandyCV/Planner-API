# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { expect(described_class).to be < ApplicationRecord }
  it { is_expected.to have_attribute(:id) }
  it { is_expected.to have_attribute(:email) }
  it { is_expected.to have_secure_password }
  it { is_expected.to have_attribute(:created_at) }
  it { is_expected.to have_attribute(:updated_at) }
end
