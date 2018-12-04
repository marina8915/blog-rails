Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
  end

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
