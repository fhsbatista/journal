require 'rails_helper'

RSpec.describe Api::AreasController, type: :controller do
  let!(:area) { Area.create(description: 'Sample Area') }

  describe 'GET #index' do
    it 'returns all areas' do
      get :index, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

  describe 'GET #show' do
    it 'returns the requested area' do
      get :show, params: { id: area.id }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['description']).to eq('Sample Area')
    end

    it 'returns a 404 if the area does not exist' do
      get :show, params: { id: 'invalid' }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Area not found')
    end
  end

  describe 'POST #create' do
    it 'creates a new area' do
      expect {
        post :create, params: { area: { description: 'New Area' } }, format: :json
      }.to change(Area, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['description']).to eq('New Area')
    end

    it 'returns a 422 if the description is missing' do
      post :create, params: { area: { description: nil } }, format: :json
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Description can't be blank")
    end
  end

  describe 'PATCH #update' do
    it 'updates the requested area' do
      patch :update, params: { id: area.id, area: { description: 'Updated Area' } }, format: :json
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['description']).to eq('Updated Area')
    end

    it 'returns a 404 if the area does not exist' do
      patch :update, params: { id: 'invalid', area: { description: 'Some Area' } }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Area not found')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the requested area' do
      expect {
        delete :destroy, params: { id: area.id }, format: :json
      }.to change(Area, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it 'returns a 404 if the area does not exist' do
      delete :destroy, params: { id: 'invalid' }, format: :json
      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)['error']).to eq('Area not found')
    end
  end
end
