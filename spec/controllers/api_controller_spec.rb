# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApiController do
  it { expect(described_class).to be < ActionController::API }
  it { expect(described_class).to include(Response) }
  it { expect(described_class).to include(JWTSessions::RailsAuthorization) }

  describe 'callbacks' do
    it 'has before_action to authorize access session' do
      expect(described_class._process_action_callbacks.map(&:filter)).to include(:authorize_access_session)
    end
  end

  describe 'rescue_from' do
    it 'rescues from JWTSessions::Errors::Unauthorized' do
      rescue_handlers = described_class.rescue_handlers
      unauthorized_handler = rescue_handlers.find { |h| h.first == 'JWTSessions::Errors::Unauthorized' }
      expect(unauthorized_handler).to be_present
      expect(unauthorized_handler.last).to eq(:not_authorized)
    end
  end

  describe 'private methods' do
    let(:controller) { described_class.new }
    let(:user) { create(:user, :confirmed) }

    describe '#authorize_access_session' do
      it 'is defined as a private method' do
        expect(described_class.private_instance_methods).to include(:authorize_access_session)
      end
    end

    describe '#current_user' do
      it 'is defined as a private method' do
        expect(described_class.private_instance_methods).to include(:current_user)
      end

      it 'returns user from payload' do
        allow(controller).to receive(:payload).and_return({ 'user_id' => user.id })
        expect(controller.send(:current_user)).to eq(user)
      end

      it 'memoizes the user' do
        allow(controller).to receive(:payload).and_return({ 'user_id' => user.id })
        expect(User).to receive(:find).once.and_return(user)
        2.times { controller.send(:current_user) }
      end
    end

    describe '#not_authorized' do
      it 'is defined as a private method' do
        expect(described_class.private_instance_methods).to include(:not_authorized)
      end
    end
  end
end
