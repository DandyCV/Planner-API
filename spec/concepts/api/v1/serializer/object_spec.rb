# frozen_string_literal: true

RSpec.describe Api::V1::Serializer::Object do
  describe '#to_json' do
    subject(:object_serializer) { described_class.new(object).to_json }

    let(:object) { { attribute => value } }
    let(:attribute) { :some_attribute }
    let(:value) { 'some value' }
    let(:object_hash) do
      {
        'data' => {
          'attributes' => { attribute.to_s => value }
        }
      }
    end

    it 'uses memoized data' do
      expect_any_instance_of(described_class).to receive(:data).once.and_call_original
      2.times { object_serializer }
    end

    it 'returns object as serialized json with jsonapi specification' do
      expect(JSON.parse(object_serializer)).to eq(object_hash)
    end
  end
end
