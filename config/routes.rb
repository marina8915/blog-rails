Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'posts/index'

  resources :posts do
    resources :comments
  end

  resources :users
  get 'users/:id/my_posts' => 'users#my_posts', as: 'my_posts'
  get 'users/:id/my_comments' => 'users#my_comments', as: 'my_comments'
  resources :sessions
  delete 'logout' => 'sessions#destroy'
  root 'posts#index'
end
