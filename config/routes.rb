Rails.application.routes.draw do
  root to: 'homes#top'

  devise_for :users, controllers:{
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }

  # deviseに新しいアクションを設定する
  devise_scope :user do 
    post '/users/guest_sign_in', to: 'users/sessions#new_guest'
  end
  resources :users do
    resource :relationships, only: [:create, :destroy]
    # get -> followingsしてくれている人全員を表示。member -> ルーティングにidを含める
    get :followings, on: :member
    # get : follower全員を表示。menber -> ルーティングにidを含める
    get :followers, on: :member
  end

  get '/users', to: 'users#index'
  
  # :todosの中にmemberを取り出す
  resources :todos do #追加
    member do #追加
      put :is_finished
      put :is_release
    end
  end

  get '/myindex', to: 'todos#myindex'
  
  get '/search', to: 'searchs#search'
  
  resources :requests
  
end
