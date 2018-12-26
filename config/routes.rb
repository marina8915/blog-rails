Rails.application.routes.draw do
  get 'admin/users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
    resources :ratings, only: [:create, :destroy]
  end

  post 'comment/likes' => 'likes#create', as: 'comment_likes'
  delete 'comment/:comment_id/likes/:id' => 'likes#destroy', as: 'delete_like'

  get ':name/posts' => 'posts#index', as: 'user_posts'
  get ':name/posts/order/:by' => 'posts#index', as: 'order_user'

  get 'order/:by' => 'posts#index', as: 'order'

  resources :users do
    member do
      get 'posts'
      get 'comments'
    end
  end

  get '/tagged', to: 'posts#index', as: :tagged

  resources :sessions, only: [:new, :create]
  resources :password_resets
  delete 'logout' => 'sessions#destroy'
  root 'posts#index'
end
