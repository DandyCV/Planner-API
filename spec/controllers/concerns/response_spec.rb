# frozen_string_literal: true

RSpec.describe Response do
  describe '.respond_with' do
    subject(:respond_with) { test_class_instance.respond_with(**args) }

    let(:test_class_instance) do
      Class.new do
        include Response

        define_method(:render) { |_| }
      end.new
    end
    let(:entity) { { a: 1 } }
    let(:args) { { entity: entity } }

    context 'with default params' do
      it 'calls render with default params' do
        expect(test_class_instance).to receive(:render).with(json: entity, status: 200)
        respond_with
      end
    end

    context 'with custom params' do
      let(:serialized_entity) { { id: 1, **entity } }
      let(:serializer_class) { class_double('TestSerializerClass') }
      let(:serializer_class_instance) { instance_double('TestSerializerInstance', to_json: serialized_entity) }
      let(:status) { :some_status }
      let(:args) { { entity: entity, status: status, serializer: serializer_class } }

      it 'calls render with custom params' do
        expect(serializer_class).to receive(:new).with(entity).and_return(serializer_class_instance)
        expect(test_class_instance).to receive(:render).with(json: serialized_entity, status: status)
        respond_with
      end
    end
  end
end
