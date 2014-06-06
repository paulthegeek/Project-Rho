require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  # You can have the root of your site routed with "root"
  resources :publishers
  
  root 'publishers#index'
end
