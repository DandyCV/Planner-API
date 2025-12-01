# frozen_string_literal: true

RSpec.describe 'Healthchecks' do
  describe 'GET /api/v1/healthcheck' do
    before { get '/api/v1/healthcheck' }

    it 'returns ok status' do
      expect(response).to be_successful
      body = response.parsed_body
      expect(body.dig('data', 'attributes', 'status')).to eq('ok')
      expect(body.dig('data', 'attributes')).to have_key('timestamp')
    end
  end

  describe 'GET /' do
    before { get '/' }

    it 'returns ok status' do
      expect(response).to be_successful
      body = response.parsed_body
      expect(body.dig('data', 'attributes', 'status')).to eq('ok')
    end
  end
end
