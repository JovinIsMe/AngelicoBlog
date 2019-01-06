Rails.application.routes.draw do

  root to: 'blog/posts#index'

  namespace :author do
    resources :posts
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
