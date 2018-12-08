Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
    resources :ratings
  end
  get ':name/posts' => 'posts#index', as: 'user_posts'
  get 'order/:by' => 'posts#index', as: 'order'

  resources :users do
    member do
      get 'posts'
      get 'comments'
    end
  end

  resources :sessions
  delete 'logout' => 'sessions#destroy'
  root 'posts#index'
end
