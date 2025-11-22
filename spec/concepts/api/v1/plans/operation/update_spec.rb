# frozen_string_literal: true

RSpec.describe Api::V1::Plans::Operation::Update do
  describe '.call' do
    subject(:operation) { described_class.call(params, current_user: user) }

    let(:user) { create(:user) }
    let(:plan) { create(:plan, user: user) }
    let(:new_title) { Faker::Lorem.sentence(word_count: 3) }
    let(:params) { { id: plan.id, title: new_title } }

    describe 'Success' do
      it 'updates the plan' do
        expect { operation }.to change { plan.reload.title }.to(new_title)
        expect(operation.success).to eq(plan)
        expect(operation).to be_success
      end
    end

    describe 'Failure' do
      context 'when plan does not exist' do
        let(:params) { { id: 999_999, title: new_title } }

        it 'returns not found error' do
          expect(operation.failure).to be_a(Hash)
          expect(operation.failure[:errors]).to be_present
          expect(operation).to be_failure
        end
      end

      context 'when plan belongs to another user' do
        let(:another_user) { create(:user) }
        let(:another_plan) { create(:plan, user: another_user) }
        let(:params) { { id: another_plan.id, title: new_title } }

        it 'returns not found error' do
          expect(operation.failure).to be_a(Hash)
          expect(operation.failure[:errors]).to be_present
          expect(operation).to be_failure
        end
      end

      context 'when title is invalid' do
        let(:params) { { id: plan.id, title: '' } }

        it 'returns validation errors' do
          expect { operation }.not_to(change { plan.reload.title })
          expect(operation.failure).to be_an_instance_of(Dry::Validation::Result)
          expect(operation.failure.errors).not_to be_empty
          expect(operation).to be_failure
        end
      end
    end
  end
end
