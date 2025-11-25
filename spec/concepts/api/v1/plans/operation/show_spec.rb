# frozen_string_literal: true

RSpec.describe Api::V1::Plans::Operation::Show do
  describe '.call' do
    subject(:operation) { described_class.call(params, current_user: user) }

    let(:user) { create(:user) }
    let(:plan) { create(:plan, user: user) }
    let(:params) { { id: plan.id } }

    describe 'Success' do
      it 'returns the plan' do
        expect(operation.success).to eq(plan)
        expect(operation).to be_success
      end
    end

    describe 'Failure' do
      context 'when plan does not exist' do
        let(:params) { { id: 999_999 } }

        it 'returns not found error' do
          expect(operation.failure).to be_a(Hash)
          expect(operation.failure[:errors]).to be_present
          expect(operation).to be_failure
        end
      end

      context 'when plan belongs to another user' do
        let(:another_user) { create(:user) }
        let(:another_plan) { create(:plan, user: another_user) }
        let(:params) { { id: another_plan.id } }

        it 'returns not found error' do
          expect(operation.failure).to be_a(Hash)
          expect(operation.failure[:errors]).to be_present
          expect(operation).to be_failure
        end
      end
    end
  end
end
