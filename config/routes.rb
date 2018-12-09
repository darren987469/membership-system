Rails.application.routes.draw do
  mount API::BaseAPI => 'api'

  devise_for :users

  root to: 'products#index'
  resources :products, only: %i[index]
  patch '/users/upgrade_to_premium', to: 'users#upgrade_to_premium', as: :upgrade_to_premium

  namespace :admin do
    resources :users, only: %i[index update]
    resources :products, only: %i[index show create new edit update]
  end
end
