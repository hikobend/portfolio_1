Rails.application.routes.draw do
  root to: 'home#top'

  devise_for :users

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
  
  get '/search', to: 'searchs#search'

  resources :groups do
    get "join" => "groups#join"
  end
  
end
