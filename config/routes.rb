Rails.application.routes.draw do
  
  root to: 'home#top'
  devise_for :users
  resource :user, except: [:new, :create, :destroy]
  resources :todos
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
