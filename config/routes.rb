Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :drugs
  resources :exams
  resources :patients
end
