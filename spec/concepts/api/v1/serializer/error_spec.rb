# frozen_string_literal: true

RSpec.describe Api::V1::Serializer::Error do
  describe '#to_json' do
    subject(:error_serializer) { described_class.new(object).to_json }

    let(:object) { instance_double('SerializableObject', errors: [error_object]) }
    let(:error_object) { instance_double('ErrorleObject', path: [pointer], text: detail) }
    let(:pointer) { :some_pointer }
    let(:detail) { 'some detail' }
    let(:json_schema) do
      {
        'errors' => [
          {
            'source' => { 'pointer' => "/data/attributes/#{pointer}" },
            'detail' => detail
          }
        ]
      }
    end

    context 'when error is an object' do
      it 'uses memoized errors' do
        expect_any_instance_of(described_class).to receive(:errors).once.and_call_original
        2.times { error_serializer }
      end

      it 'returns errors as serialized json with jsonapi specification' do
        expect(JSON.parse(error_serializer)).to eq(json_schema)
      end
    end

    context 'when error is a Hash' do
      let(:object) { { errors: [{ pointer => detail }] } }

      it 'returns errors as serialized json with jsonapi specification' do
        expect(JSON.parse(error_serializer)).to eq(json_schema)
      end
    end
  end
end
