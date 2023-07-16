Rails.application.routes.draw do
  resources :journal_entries, only: [:index, :create, :show]
  
  get 'journal_entries/date/:date', to: 'journal_entries#by_date', as: "journal_entries_by_date"
  
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'sign_up'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
