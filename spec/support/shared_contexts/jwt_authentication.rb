# frozen_string_literal: true

RSpec.shared_context 'with jwt authentication' do
  let(:password) { random_password }
  let(:user) { create(:user, :confirmed, password: password) }
  let(:api_session) { Api::V1::Lib::Service::Session.create_session(user) }
  let(:headers) { { 'Authorization' => "Bearer #{api_session[:access]}" } }
end
