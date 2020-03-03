Rails.application.routes.draw do

  root "posts#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # devise_for :users, path: 'admin'
  get 'posts/odd_even_filter' => 'posts#odd_even_filter', as: :odd_even_filter
  resources :posts
  post 'posts/search' => 'posts#search', as: :post_search
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
end
