# frozen_string_literal: true

devise_for :users, skip: :all

namespace :users do
  use_doorkeeper do
    controllers tokens: 'tokens'
    skip_controllers :applications, :authorized_applications, :authorizations
  end

  post 'sign_up', to: 'registrations#create', as: :registration
  post 'password', to: 'passwords#create', as: :password
  patch 'password', to: 'passwords#update', as: nil
end

# NOTE: Must use resources to define routes. They cannot be explicitly defined as above.
#       It creates routes not found error
resources :cages
resources :dinosaurs

# post 'cages', to: 'cages#create'
# get 'cages', to: 'cages#index'
# get 'cages/:id', to: 'cages#show'
# patch 'cages/:id', to: 'cages#update'
# delete 'cages/:id', to: 'cages#destroy'

  # get 'dinosaurs', to: 'dinosaurs#index'
  # get 'dinosaurs/:id', to: 'dinosaurs#show'
  # post 'dinosaurs', to: 'dinosaurs#create'
  # patch 'dinosaurs/:id/move/:cage_id', to: 'dinosaurs#move'
  # patch 'dinosaurs', to: 'dinosaurs#update'
