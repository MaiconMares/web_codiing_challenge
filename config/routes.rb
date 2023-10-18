Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "conferences#index"
  
  resources :conferences, only: [:index]
  resources :schedulings

  get "conferences/new", to: "conferences#new", :as => :new_conference
  get "conferences/edit/:id", to: "conferences#edit", :as => :edit_conference
  delete "conferences/:id", to: "conferences#destroy", :as => :delete_conference
  post "conferences/:id", to: "conferences#update"
  post "conferences", to: "conferences#create"
  get "conferences/:id", to: "conferences#show", :as => :conference
  

  # Defines the root path route ("/")
  # root "posts#index"
end
