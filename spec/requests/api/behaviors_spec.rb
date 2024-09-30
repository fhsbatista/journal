require 'rails_helper'

RSpec.describe Api::BehaviorsController, type: :controller do
  let!(:behavior) { Behavior.create(description: 'Test Behavior') }

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
        post :create, params: { behavior: { description: 'New Behavior' } }
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
end
