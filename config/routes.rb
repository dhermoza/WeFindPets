Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :pets do
    collection do
      get :lost
      get :found
    end
    resources :posts
  end

  get 'post/locate', to: "posts#locate", as: :locate
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
