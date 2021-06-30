# frozen_string_literal: true

RSpec.describe User, type: :model do
  it { expect(described_class).to be < ApplicationRecord }
  it { is_expected.to have_db_column(:id).of_type(:integer) }
  it { is_expected.to have_db_column(:email).of_type(:string) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }
  it { is_expected.to have_secure_password }
end
