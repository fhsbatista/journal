require 'rails_helper'

RSpec.describe Api::ScoresController, type: :controller do
  let!(:area) { Area.create(description: 'Sample Behavior') }
  let!(:behavior) { Behavior.create(description: 'Sample Behavior', area_id: area.id) }
  let!(:score) { Score.create(score: 5.0, description: 'Good', behavior: behavior) }

  describe 'GET #index' do
    it 'returns all scores' do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'returns the requested score' do
      get :show, params: { id: score.id }, format: :json
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['description']).to eq('Good')
    end

    it 'returns a not found error for invalid score' do
      get :show, params: { id: 'invalid' }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    it 'creates a new score' do
      expect {
        post :create, params: { score: { score: 4.0, description: 'Average', behavior_id: behavior.id } }, format: :json
      }.to change(Score, :count).by(1)

      expect(response).to have_http_status(:created)
    end

    it 'returns an error when score is missing' do
      post :create, params: { score: { score: nil, behavior_id: behavior.id } }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH #update' do
    it 'updates an existing score' do
      patch :update, params: { id: score.id, score: { score: 6.0 } }, format: :json
      expect(response).to have_http_status(:success)
      expect(score.reload.score).to eq(6.0)
    end

    it 'returns a not found error for invalid score' do
      patch :update, params: { id: 'invalid', score: { score: 6.0 } }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes an existing score' do
      expect {
        delete :destroy, params: { id: score.id }, format: :json
      }.to change(Score, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it 'returns a not found error for invalid score' do
      delete :destroy, params: { id: 'invalid' }, format: :json
      expect(response).to have_http_status(:not_found)
    end
  end
end
