Rails.application.routes.draw do
  
  root to: 'home#top'
  devise_for :users
  resource :user
  get '/users', to: 'users#index'
  resources :todos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
