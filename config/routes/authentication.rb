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

resources :cages
resources :dinosaurs, except: :update

patch 'dinosaurs/:id/move/:cage_id', to: 'dinosaurs#move', as: 'dinosaur_move'
patch 'dinosaurs/:id', to: 'dinosaurs#update', as: 'dinosaur_update'
