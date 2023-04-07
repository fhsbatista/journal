Rails.application.routes.draw do
  resources :journal_entries, only: [:index, :create]
  get 'journal_entries/date/:date', to: 'journal_entries#by_date', as: "journal_entries_by_date"
end
