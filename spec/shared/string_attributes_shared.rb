# frozen_string_literal: true

shared_examples 'string attributes' do
  context 'when required attributes are missing' do
    let(:params) { {} }

    it 'returns failed contract with errors' do
      expect_errors(result, attrs, 'is missing')
      expect(result).to be_failure
    end
  end

  context 'when required attributes are blank' do
    let(:params) { (attrs.zip Array.new(attrs.size, '')).to_h }

    it 'returns failed contract with errors' do
      expect_errors(result, attrs, 'must be filled')
      expect(result).to be_failure
    end
  end

  context 'when required attributes have wrong type' do
    let(:params) { (attrs.zip Array.new(attrs.size, [:attr])).to_h }

    it 'returns failed contract with errors' do
      expect_errors(result, attrs, 'must be a string')
      expect(result).to be_failure
    end
  end
end
