Rails.application.routes.draw do
  namespace :api do
    resources :behaviors
    resources :scores
  end
end
