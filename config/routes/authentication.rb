# frozen_string_literal: true

devise_for :users, skip: :all
devise_for :cages, skip: :all
devise_for :dinosaurs, skip: :all

namespace :users do
  use_doorkeeper do
    controllers tokens: 'tokens'
    skip_controllers :applications, :authorized_applications, :authorizations
  end

  post 'sign_up', to: 'registrations#create', as: :registration
  post 'password', to: 'passwords#create', as: :password
  patch 'password', to: 'passwords#update', as: nil

  #get 'cages', to: 'cage#index', as: :list_cages
  #get 'cages/:id', to: 'cage#show', as: :show_cage
  # get 'cages', to: 'cage#fetch', as: :list_cages
  # get 'cages/:id', to: 'cage#fetch', as: :show_cage
  # post 'cages', to: 'cages#create', as: :create_cage
  # patch 'cages/:id', to: 'cages#update', as: :edit_cage

  #get 'dinosaurs', to: 'dinosaurs#index', as: :list_dinosaurs
  #get 'dinosaurs/:id', to: 'dinosaurs#show', as: :show_dinosaur
  # get 'dinosaurs', to: 'dinosaurs#fetch', as: :list_dinosaurs
  # get 'dinosaurs/:id', to: 'dinosaurs#fetch', as: :show_dinosaur
  # post 'dinosaurs', to: 'dinosaurs#create', as: :create_dinosaur
  # patch 'dinosaurs/:id/move/:cage_id', to: 'dinosaurs#move', as: :move_dinosaur
  # patch 'dinosaurs/:id', to: 'dinosaurs#update', as: :edit_dinosaur
end

#namespace :v1 do
  #get 'cages', to: 'cage#index', as: :list_cages
  #get 'cages/:id', to: 'cage#show', as: :show_cage
  # get 'cages', to: 'cage#fetch', as: :list_cages
  # get 'cages/:id', to: 'cage#fetch', as: :show_cage
  # post 'cages', to: 'cages#create', as: :create_cage
  # patch 'cages/:id', to: 'cages#update', as: :edit_cage

  #get 'dinosaurs', to: 'dinosaurs#index', as: :list_dinosaurs
  #get 'dinosaurs/:id', to: 'dinosaurs#show', as: :show_dinosaur
  # get 'dinosaurs', to: 'dinosaurs#fetch', as: :list_dinosaurs
  # get 'dinosaurs/:id', to: 'dinosaurs#fetch', as: :show_dinosaur
  # post 'dinosaurs', to: 'dinosaurs#create', as: :create_dinosaur
  # patch 'dinosaurs/:id/move/:cage_id', to: 'dinosaurs#move', as: :move_dinosaur
  # patch 'dinosaurs/:id', to: 'dinosaurs#update', as: :edit_dinosaur
#end

  get 'cages', to: 'cages#index'
  get 'cages/:id', to: 'cages#show'
  post 'cages', to: 'cages#create'
  patch 'cages/:id', to: 'cages#update'

  #get 'dinosaurs', to: 'dinosaurs#index', as: :list_dinosaurs
  #get 'dinosaurs/:id', to: 'dinosaurs#show', as: :show_dinosaur
  get 'dinosaurs', to: 'dinosaurs#index'
  get 'dinosaurs/:id', to: 'dinosaurs#show'
  post 'dinosaurs', to: 'dinosaurs#create'
  patch 'dinosaurs/:id/move/:cage_id', to: 'dinosaurs#move'
  patch 'dinosaurs/:id', to: 'dinosaurs#update'
