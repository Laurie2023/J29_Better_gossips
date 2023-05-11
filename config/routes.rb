Rails.application.routes.draw do
  get 'welcome/index'
  get '/welcome/contact', to: 'welcome#contact'
  get '/welcome/team', to: 'welcome#team'
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :gossips
  resources :users
  resources :cities
  resources :sessions, only: [:new, :create, :destroy]

  resources :gossips do
    resources :comments
  end

  resources :likes, only: [:index, :new, :create, :destroy]

end
