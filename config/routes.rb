Rails.application.routes.draw do
  resources :posts
  resources :users

  root 'posts#index'

  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  post 'add_role' => 'users#grant'
  post 'delete_role' => 'users#revoke'
end
