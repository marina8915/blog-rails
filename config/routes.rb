Rails.application.routes.draw do
  get 'users/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'posts/index'

  resources :posts do
    resources :comments
  end

  resources :users
  get 'users/:id/my_posts' => 'users#show', as: 'my_posts'
  resources :sessions
  delete 'logout' => 'sessions#destroy'
  root 'posts#index'
end
