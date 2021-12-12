Rails.application.routes.draw do
  root to: 'home#top'
  devise_for :users
  # resource :user
  resources :users
  get '/users', to: 'users#index'
  # :todosの中にmemberを取り出す
  resources :todos do #追加
    member do #追加
      put :is_finished
      put :is_release
    end
  end
  get '/search', to: 'searchs#search'
end
