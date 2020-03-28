Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # 'controller#action'
  root "pages#home"

  # The priority is based on the order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # route /about goes to controller pages_controller and calls the about method.
  get "about", to: "pages#about"

  # Add the routes index, create, new, edit, show, update and destroy. --rake routes-- to see.
  resources :articles

  # route /signup goes to controller users_controller and calls the new method.
  get "signup", to: "users#new"

  # Add the routes index, create, edit, show, update and destroy. all the normal routes resources provides except new.
  resources :users, except: [:new]

  # route /login goes to controller sessions_controller and calls the new method.
  get "login", to: "sessions#new"

  # route /login goes to controller sessions_controller and calls the create method when you attempt to create a user on that page/route.
  post "login", to: "sessions#create"

  # route /logout goes to controller sessions_controller and calls the destroy method.
  delete "logout", to: "sessions#destroy"

  # Add the routes index, create, edit, show, update and new . all the normal routes resources provides except destroy.
  resources :categories, except: [:destroy]
end
