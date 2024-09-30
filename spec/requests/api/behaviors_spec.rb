require 'rails_helper'

RSpec.describe Api::BehaviorsController, type: :controller do
  let(:area) { Area.create(description: 'Sample Area') }
  let!(:behavior) { Behavior.create(description: 'Test Behavior', area_id: area.id) }

  describe 'GET #index' do
    it 'returns all behaviors' do
      get :index, format: :json
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'returns the behavior for a given id' do
      get :show, params: { id: behavior.id }
      expect(response).to be_successful
      expect(JSON.parse(response.body)['description']).to eq('Test Behavior')
    end

    it 'returns a not found error for invalid id' do
      get :show, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    it 'creates a new behavior' do
      expect {
        post :create, params: { behavior: { description: 'New Behavior', area_id: area.id } }
      }.to change(Behavior, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it 'returns an error when description is missing' do
      post :create, params: { behavior: { description: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH #update' do
    it 'updates an existing behavior' do
      patch :update, params: { id: behavior.id, behavior: { description: 'Updated Behavior' } }
      expect(response).to be_successful
      expect(Behavior.find(behavior.id).description).to eq('Updated Behavior')
    end

    it 'returns a not found error for invalid id' do
      patch :update, params: { id: 'invalid_id', behavior: { description: 'Test' } }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the behavior' do
      expect {
        delete :destroy, params: { id: behavior.id }
      }.to change(Behavior, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it 'returns a not found error for invalid id' do
      delete :destroy, params: { id: 'invalid_id' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET #latest_score' do
    before do
      Score.create(score: 4.0, description: 'old score', behavior: behavior)
      Score.create(score: 5.0, description: 'last score', behavior: behavior)
    end

    it 'returns the latest score for the behavior' do
      get :latest_score, params: { id: behavior.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['score']).to eq(5.0)
      expect(JSON.parse(response.body)['description']).to eq('last score')
    end

    it 'returns not found if no scores exist for the behavior' do
      behavior.scores.delete_all # Remove all scores
      get :latest_score, params: { id: behavior.id }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['message']).to eq('No scores found for this behavior')
    end

    it 'returns not found if the behavior does not exist' do
      get :latest_score, params: { id: 'invalid' }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create_event' do
    before do
      Score.create(score: 8.0, description: 'old score', behavior: behavior)
    end

    it 'creates a new event for the behavior' do
      expect {
        post :create_event, params: { id: behavior.id }, format: :json
      }.to change(Event, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['score']).to eq(8.0)
      expect(JSON.parse(response.body)['behavior_id']).to eq(behavior.id.to_s)
    end

    it 'returns an error if the behavior does not exist' do
      post :create_event, params: { id: 'invalid' }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
