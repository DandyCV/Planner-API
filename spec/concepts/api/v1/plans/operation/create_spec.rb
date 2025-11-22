# frozen_string_literal: true

RSpec.describe Api::V1::Plans::Operation::Create do
  describe '.call' do
    subject(:operation) { described_class.call(params, current_user: user) }

    let(:user) { create(:user) }
    let(:title) { Faker::Lorem.sentence(word_count: 3) }
    let(:params) { { title: title } }

    describe 'Success' do
      it 'creates a new plan' do
        expect { operation }.to change(Plan, :count).from(0).to(1)
        expect(operation.success).to be_an_instance_of(Plan)
        expect(operation.success.title).to eq(title)
        expect(operation.success.user).to eq(user)
        expect(operation).to be_success
      end
    end

    describe 'Failure' do
      context 'when plan with invalid params' do
        let(:params) { { title: '' } }

        it 'returns errors' do
          expect { operation }.not_to change(Plan, :count)
          expect(operation.failure).to be_an_instance_of(Dry::Validation::Result)
          expect(operation.failure.errors).not_to be_empty
          expect(operation).to be_failure
        end
      end
    end
  end
end
