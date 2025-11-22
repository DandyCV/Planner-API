# frozen_string_literal: true

RSpec.describe 'Plans' do
  include_context 'with jwt authentication'

  describe 'GET /api/v1/plans' do
    let!(:plans) { create_list(:plan, 3, user: user) }
    let!(:other_user_plan) { create(:plan) }

    before { get '/api/v1/plans', headers: headers }

    describe 'Success' do
      it 'renders OK' do
        expect(response).to be_successful
        expect(response).to match_json_schema('v1/plans/index/index')
      end

      it 'returns only current user plans' do
        json_response = response.parsed_body
        expect(json_response['data'].size).to eq(3)

        plan_ids = json_response['data'].map { |p| p['attributes']['id'] }
        expect(plan_ids).to match_array(plans.map(&:id))
        expect(plan_ids).not_to include(other_user_plan.id)
      end

      it 'returns plans ordered by created_at desc' do
        json_response = response.parsed_body
        plan_ids = json_response['data'].map { |p| p['attributes']['id'] }
        expected_order = plans.sort_by(&:created_at).reverse.map(&:id)
        expect(plan_ids).to eq(expected_order)
      end
    end

    describe 'Failure' do
      context 'when unauthorized' do
        let(:headers) { {} }

        it 'returns unauthorized error' do
          expect(response).to be_unauthorized
          expect(response).to match_json_schema('v1/error/401')
        end
      end
    end
  end

  describe 'POST /api/v1/plans' do
    let(:params) { { title: 'My New Plan' } }

    before { post '/api/v1/plans', params: params, headers: headers, as: :json }

    describe 'Success' do
      it 'renders created plan' do
        expect(response).to be_created
        expect(response).to match_json_schema('v1/plans/create/create')
      end

      it 'creates plan for current user' do
        json_response = response.parsed_body
        plan = Plan.find(json_response['data']['attributes']['id'])
        expect(plan.user_id).to eq(user.id)
        expect(plan.title).to eq('My New Plan')
      end

      it 'increases plans count' do
        expect { post '/api/v1/plans', params: params, headers: headers, as: :json }
          .to change(Plan, :count).by(1)
      end
    end

    describe 'Failure' do
      context 'when title is missing' do
        let(:params) { { title: '' } }

        it 'returns validation error' do
          expect(response).to be_unprocessable
          expect(response).to match_json_schema('v1/error/422')
          expect(response.body).to include('must be filled')
        end
      end

      context 'when title is not provided' do
        let(:params) { {} }

        it 'returns validation error' do
          expect(response).to be_unprocessable
          expect(response).to match_json_schema('v1/error/422')
        end
      end

      context 'when unauthorized' do
        let(:headers) { {} }

        it 'returns unauthorized error' do
          expect(response).to be_unauthorized
          expect(response).to match_json_schema('v1/error/401')
        end
      end
    end
  end

  describe 'GET /api/v1/plans/:id' do
    let(:plan) { create(:plan, user: user) }

    before { get "/api/v1/plans/#{plan.id}", headers: headers }

    describe 'Success' do
      it 'renders plan' do
        expect(response).to be_successful
        expect(response).to match_json_schema('v1/plans/show/show')
      end

      it 'returns correct plan data' do
        json_response = response.parsed_body
        expect(json_response['data']['attributes']['id']).to eq(plan.id)
        expect(json_response['data']['attributes']['title']).to eq(plan.title)
      end
    end

    describe 'Failure' do
      context 'when plan does not exist' do
        before { get '/api/v1/plans/999999', headers: headers }

        it 'returns not found error' do
          expect(response).to be_not_found
          expect(response).to match_json_schema('v1/error/404')
          expect(response.body).to include(I18n.t('plans.operation.not_found'))
        end
      end

      context 'when plan belongs to another user' do
        let(:other_user_plan) { create(:plan) }

        before { get "/api/v1/plans/#{other_user_plan.id}", headers: headers }

        it 'returns not found error' do
          expect(response).to be_not_found
          expect(response).to match_json_schema('v1/error/404')
          expect(response.body).to include(I18n.t('plans.operation.not_found'))
        end
      end

      context 'when unauthorized' do
        let(:headers) { {} }

        it 'returns unauthorized error' do
          expect(response).to be_unauthorized
          expect(response).to match_json_schema('v1/error/401')
        end
      end
    end
  end

  describe 'PATCH /api/v1/plans/:id' do
    let(:plan) { create(:plan, user: user, title: 'Old Title') }
    let(:params) { { title: 'Updated Title' } }

    before { patch "/api/v1/plans/#{plan.id}", params: params, headers: headers, as: :json }

    describe 'Success' do
      it 'renders updated plan' do
        expect(response).to be_successful
        expect(response).to match_json_schema('v1/plans/update/update')
      end

      it 'updates plan title' do
        json_response = response.parsed_body
        expect(json_response['data']['attributes']['title']).to eq('Updated Title')
        expect(plan.reload.title).to eq('Updated Title')
      end

      it 'does not change plan ownership' do
        expect(plan.reload.user_id).to eq(user.id)
      end
    end

    describe 'Failure' do
      context 'when title is empty' do
        let(:params) { { title: '' } }

        it 'returns validation error' do
          expect(response).to be_unprocessable
          expect(response).to match_json_schema('v1/error/422')
          expect(response.body).to include('must be filled')
        end

        it 'does not update plan' do
          expect(plan.reload.title).to eq('Old Title')
        end
      end

      context 'when plan does not exist' do
        before { patch '/api/v1/plans/999999', params: params, headers: headers, as: :json }

        it 'returns not found error' do
          expect(response).to be_not_found
          expect(response).to match_json_schema('v1/error/404')
          expect(response.body).to include(I18n.t('plans.operation.not_found'))
        end
      end

      context 'when plan belongs to another user' do
        let(:other_user_plan) { create(:plan, title: 'Other User Plan') }

        before { patch "/api/v1/plans/#{other_user_plan.id}", params: params, headers: headers, as: :json }

        it 'returns not found error' do
          expect(response).to be_not_found
          expect(response).to match_json_schema('v1/error/404')
          expect(response.body).to include(I18n.t('plans.operation.not_found'))
        end

        it 'does not update the plan' do
          expect(other_user_plan.reload.title).to eq('Other User Plan')
        end
      end

      context 'when unauthorized' do
        let(:headers) { {} }

        it 'returns unauthorized error' do
          expect(response).to be_unauthorized
          expect(response).to match_json_schema('v1/error/401')
        end
      end
    end
  end

  describe 'DELETE /api/v1/plans/:id' do
    let!(:plan) { create(:plan, user: user) }

    describe 'Success' do
      it 'destroys the plan' do
        expect { delete "/api/v1/plans/#{plan.id}", headers: headers }
          .to change(Plan, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end

      it 'returns no content' do
        delete "/api/v1/plans/#{plan.id}", headers: headers
        expect(response.body).to be_empty
      end
    end

    describe 'Failure' do
      context 'when plan does not exist' do
        before { delete '/api/v1/plans/999999', headers: headers }

        it 'returns not found error' do
          expect(response).to be_not_found
          expect(response).to match_json_schema('v1/error/404')
          expect(response.body).to include(I18n.t('plans.operation.not_found'))
        end
      end

      context 'when plan belongs to another user' do
        let!(:other_user_plan) { create(:plan) }

        before { delete "/api/v1/plans/#{other_user_plan.id}", headers: headers }

        it 'returns not found error' do
          expect(response).to be_not_found
          expect(response).to match_json_schema('v1/error/404')
          expect(response.body).to include(I18n.t('plans.operation.not_found'))
        end

        it 'does not destroy the plan' do
          expect(Plan.exists?(other_user_plan.id)).to be true
        end
      end

      context 'when unauthorized' do
        let(:headers) { {} }

        before { delete "/api/v1/plans/#{plan.id}", headers: headers }

        it 'returns unauthorized error' do
          expect(response).to be_unauthorized
          expect(response).to match_json_schema('v1/error/401')
        end

        it 'does not destroy the plan' do
          expect(Plan.exists?(plan.id)).to be true
        end
      end
    end
  end
end
