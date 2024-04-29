Rails.application.routes.draw do
  namespace :backoffice do
    resources :attendants, except: [:show]
    resources :doctors, except: [:show]
    resources :managers, except: [:show]
    resources :calendar, only: [:index]
    resource :home, only: [:index]
    resources :appointments
    resources :patients
    get "statistics/weekly_for_patient", to: "statistics#weekly_for_patient"
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
