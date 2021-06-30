# frozen_string_literal: true

shared_context 'when required attributes are strings' do
  context 'when required attributes are missing' do
    let(:params) { {} }

    it 'returns failed contract with errors' do
      expect_errors(contract, attrs, 'is missing')
      expect(contract).to be_failure
    end
  end

  context 'when required attributes are blank' do
    let(:params) { (attrs.zip Array.new(attrs.size, '')).to_h }

    it 'returns failed contract with errors' do
      expect_errors(contract, attrs, 'must be filled')
      expect(contract).to be_failure
    end
  end

  context 'when required attributes have wrong type' do
    let(:params) { (attrs.zip Array.new(attrs.size, [:attr])).to_h }

    it 'returns failed contract with errors' do
      expect_errors(contract, attrs, 'must be a string')
      expect(contract).to be_failure
    end
  end
end
