# frozen_string_literal: true

RSpec.describe ApplicationContract do
  it { expect(described_class).to be < Dry::Validation::Contract }
  it { expect(described_class.config.messages.default_locale).to eq(:en) }

  describe '.call' do
    subject(:contract) do
      Class.new(described_class) do
        params { required(:param) }
      end.call(ctx)
    end

    let(:values) { { param: 42 } }

    shared_examples 'returns contract instance with new getters from params keys' do
      it 'returns contract instance with new getters from params keys' do
        expect(values.all? { |attribute, value| contract.public_send(attribute) == value }).to be(true)
        contract
      end
    end

    context 'when params is ActionController::Parameters instance' do
      let(:ctx) { ActionController::Parameters.new(values) }

      include_examples 'returns contract instance with new getters from params keys'
    end

    context 'when params is a Hash instance' do
      let(:ctx) { values }

      include_examples 'returns contract instance with new getters from params keys'
    end
  end
end
