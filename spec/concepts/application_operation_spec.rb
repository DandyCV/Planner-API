# frozen_string_literal: true

RSpec.describe ApplicationOperation do
  it { expect(described_class.ancestors).to include(Dry::Transaction) }

  describe '.call' do
    subject(:operation) { described_class.call(ctx, &block) }

    let(:operation_instance) { instance_double('OperationInstance') }
    let(:ctx) { instance_double('Context') }
    let(:block) { ->(_) {} }

    it 'calls the instance method' do
      expect(described_class).to receive(:new).and_return(operation_instance)
      expect(operation_instance).to receive(:call).with(ctx, &block)
      operation
    end
  end
end
