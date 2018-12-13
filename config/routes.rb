Rails.application.routes.draw do
  get 'admin/users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :ratings, only: [:create]
  end
  post 'comment/likes' => 'likes#create', as: 'comment_likes'

  get ':name/posts' => 'posts#index', as: 'user_posts'
  get ':name/posts/order/:by' => 'posts#index', as: 'order_user'

  get 'order/:by' => 'posts#index', as: 'order'

  resources :users do
    member do
      get 'posts'
      get 'comments'
    end
  end

  resources :sessions, only: [:new, :create]
  delete 'logout' => 'sessions#destroy'
  root 'posts#index'
end
