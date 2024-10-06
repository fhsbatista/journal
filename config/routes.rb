Rails.application.routes.draw do
  get 'today', to: 'today#index'

  resources :behaviors do
    delete 'delete_events_today', on: :member
    post 'create_event_today', on: :member
  end

  namespace :api do
    resources :behaviors do
      member do
        get 'latest_score'
        post 'create_event'
      end
    end

    resources :areas
    resources :scores
  end
end
