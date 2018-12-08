Rails.application.routes.draw do
  mount API::BaseAPI => 'api'

  devise_for :users

  root to: 'products#index'
  resources :products, only: %i[index]

  namespace :admin do
    resources :users, only: %i[index update]
    resources :products, only: %i[index show create new edit update]
  end
end
