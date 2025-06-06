Rails.application.routes.draw do
  devise_for :users
  mount RailsDesigner::Engine, at: "/rails_designer"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :home, only: [ :index ], controller: :home
  resources :groups, only: [ :index, :show, :new, :create, :edit, :update ]
  resource :user, only: [:show, :edit, :update], controller: :user

  # Defines the root path route ("/")
  root "home#index"
end
