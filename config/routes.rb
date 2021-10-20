Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :posts do
    collection do
      get :lost
      get :found
    end
  end
  resources :pets do
    resources :posts
  end

  resources :posts do
    resources :chatrooms, only: [:create, :destroy]
  end

  resources :chatrooms, only: [:index, :show] do
    resources :messages, only: :create
  end

  get 'pet_breeds', to: "pets#get_breeds", as: :get_breeds
  get '/myposts', to: "posts#myposts", as: :my_posts
  get 'posts/locate', to: "posts#locate", as: :locate
  # get 'post/:id/edit', to: "posts#edit", as: :post_edit
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
