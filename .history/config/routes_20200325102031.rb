Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 'controller#action'
  root "pages#home"

  # route /about goes to controller pages_controller and calls the about method.
  get "about", to: "pages#about"

  # Add the routes index, create, new, edit, show, update and destroy. --rake routes-- to see.
  resources :articles

  # route /signup goes to controller users_controller and calls the new method.
  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
