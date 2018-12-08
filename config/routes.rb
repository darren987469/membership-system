Rails.application.routes.draw do
  devise_for :users

  root to: 'products#index'
  resources :products, only: %i[index]

  namespace :admin do
    resources :users, only: %i[index]
  end
end
