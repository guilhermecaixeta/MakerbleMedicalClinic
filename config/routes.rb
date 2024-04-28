Rails.application.routes.draw do
  namespace :medical_clinic do
    resources :patients
    resources :appointments
    resources :calendar, only: [:index]
  end

  namespace :backoffice do
    resources :attendants, except: [:show]
    resources :doctors, except: [:show]
    resource :home, only: [:index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "backoffice/home#index"

  # Devise
  devise_for :users, skip: [:registrations]
end
