Rails.application.routes.draw do

  devise_for :authors
  root to: 'blog/posts#index'

  namespace :authors do
    resources :posts do
      member do
        put 'publish' => 'posts#publish'
        put 'unpublish' => 'posts#unpublish'
      end
    end
    # method
    # get 'broadcast' => 'url', as: :prefix
    # get :broadcast
  end

  scope module: 'blog' do
    get 'about' => 'pages#about', as: :about
    get 'contact' => 'pages#contact', as: :contact

    get 'posts' => 'posts#index', as: :posts
    get 'posts/new' => 'posts#new', as: :new_post
    get 'posts/:id'=> 'posts#show', as: :post
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
