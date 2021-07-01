# frozen_string_literal: true

RSpec.describe Api::V1::Serializer::Error do
  let(:error_class) { class_double('TestErrorClass') }
  let(:error_class_instance) do
    instance_double('TestErrorClassInstance', path: [:email], text: I18n.t('users.registrations.contract.create.taken'))
  end
  let(:serialized_class) { class_double('TestSerializedClass') }
  let(:serialized_class_instance) { instance_double('TestSerializerInstance', errors: [error_class_instance]) }
  let(:serialized_object) { described_class.new(serialized_class_instance).to_json }

  it 'serializes object with errors' do
    expect(serialized_object).to match_json_schema('v1/error/422')
  end
end
