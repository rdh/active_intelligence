# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/simple' => 'simple#index', as: :simple_index
  post '/simple/:id' => 'simple#update', as: :simple_update

  get '/turbo' => 'turbo#index', as: :turbo_index
  post '/turbo/:id' => 'turbo#update', as: :turbo_update

  # Defines the root path route ("/")
  root 'root#index'
end
