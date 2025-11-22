# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plan do
  it { expect(described_class).to be < ApplicationRecord }
  it { is_expected.to have_db_column(:id).of_type(:integer) }
  it { is_expected.to have_db_column(:title).of_type(:string) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime) }
  it { is_expected.to have_db_column(:updated_at).of_type(:datetime) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      plan = build(:plan)
      expect(plan).to be_valid
    end
  end
end
