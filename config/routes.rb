require 'sidekiq/web'
require 'api_constraints'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'
  resources :publishers, defaults: { format: 'json' }
end
