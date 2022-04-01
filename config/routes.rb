Rails.application.routes.draw do
  root to: 'registrations#index'

  resources :drugs
  resources :exams
  resources :patients
  resources :prescriptions
  resources :registrations

  post 'login', to: 'registrations#login'
  get 'logout', to: 'registrations#logout'
end
