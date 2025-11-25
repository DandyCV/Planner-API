# frozen_string_literal: true

RSpec.describe ApplicationOperation do
  it { expect(described_class.ancestors).to include(Dry::Transaction) }

  describe '.call' do
    let(:operation_instance) { instance_double(OperationInstance) }
    let(:ctx) { { foo: 'bar' } }
    let(:block) { proc {} }

    context 'when called with params only' do
      subject(:operation) { described_class.call(ctx, &block) }

      it 'calls the instance method with params' do
        expect(described_class).to receive(:new).and_return(operation_instance)
        expect(operation_instance).to receive(:call).with(ctx, &block)
        operation
      end
    end

    context 'when called with params and keyword arguments' do
      subject(:operation) { described_class.call(ctx, current_user: user, &block) }

      let(:user) { instance_double(User) }

      it 'merges keyword arguments into params and calls the instance method' do
        expect(described_class).to receive(:new).and_return(operation_instance)
        expect(operation_instance).to receive(:call).with({ foo: 'bar', current_user: user }, &block)
        operation
      end
    end
  end
end
