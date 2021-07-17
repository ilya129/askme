Rails.application.routes.draw do
  root to: 'users#index'

  resources :users#, except: [:destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :questions, except: [:show, :new, :index]
end
