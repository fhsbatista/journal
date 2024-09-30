Rails.application.routes.draw do
  namespace :api do
    resources :behaviors do
      member do
        get 'latest_score'
        post 'create_event'
      end
    end

    resources :scores
  end
end
