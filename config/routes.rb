Rails.application.routes.draw do

  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  
  resources :authors, only: [:index]

  root to: "application#index"

  # match ':controller(/:action(/:id))', :via => :get

  

end