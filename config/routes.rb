Rails.application.routes.draw do
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
