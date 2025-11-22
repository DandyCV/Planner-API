# frozen_string_literal: true

RSpec.describe Api::V1::Plans::Serializer::Show do
  describe '#serializable_hash' do
    subject(:serialized_plan) { described_class.new(plan).serializable_hash }

    let(:user) { create(:user) }
    let(:plan) { create(:plan, user: user) }
    let(:expected_hash) do
      {
        data: {
          id: plan.id.to_s,
          type: :plan,
          attributes: {
            id: plan.id,
            title: plan.title,
            created_at: plan.created_at,
            updated_at: plan.updated_at
          }
        }
      }
    end

    it { expect(described_class).to be < ApplicationSerializer }

    it 'returns plan as serialized hash with jsonapi specification' do
      expect(serialized_plan).to eq(expected_hash)
    end

    it 'includes all required attributes' do
      attributes = serialized_plan[:data][:attributes]
      expect(attributes.keys).to contain_exactly(:id, :title, :created_at, :updated_at)
    end

    it 'sets correct type' do
      expect(serialized_plan[:data][:type]).to eq(:plan)
    end
  end

  describe '.new' do
    context 'when serializing multiple plans' do
      subject(:serialized_plans) { described_class.new(plans).serializable_hash }

      let(:user) { create(:user) }
      let(:plans) { create_list(:plan, 3, user: user) }

      it 'returns array of serialized plans' do
        expect(serialized_plans[:data]).to be_an(Array)
        expect(serialized_plans[:data].size).to eq(3)
      end

      it 'each plan has correct structure' do
        serialized_plans[:data].each do |plan_data|
          expect(plan_data[:type]).to eq(:plan)
          expect(plan_data[:attributes].keys).to contain_exactly(:id, :title, :created_at, :updated_at)
        end
      end
    end
  end
end
