# frozen_string_literal: true

RSpec.describe Api::V1::Plans::Contract::Create, type: :contract do
  subject(:contract) { described_class.call(params) }

  let(:title) { Faker::Lorem.sentence(word_count: 3) }

  describe 'Success' do
    context 'when valid params' do
      let(:params) { { title: title } }

      it 'returns valid contract' do
        expect(contract.errors).to be_empty
        expect(contract).to be_success
      end

      it 'provides access to title' do
        expect(contract.title).to eq(title)
      end
    end
  end

  describe 'Failure' do
    describe 'with invalid title' do
      let(:attrs) { %i[title] }

      it_behaves_like 'when required attributes are strings'
    end
  end
end
