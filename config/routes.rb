Meatup2::Application.routes.draw do

  match '/about', to: 'static_pages#about'

  match '/how', to: 'static_pages#how'
  match '/welcome_email', to: 'static_pages#welcome_email'
  match '/order_email', to: 'static_pages#order_email'

  match '/contact', to: 'static_pages#contact'

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/incubation', to: "static_pages#incubation"

  # match '/orders/list/:type' => "orders#list"

  resources :animals do
    resources :orders, only: [:new]
    get :purchase, on: :collection
    get :list, on: :collection
    get :labels, on: :member
    get :log, on: :member
  end

  resources :orders, except: [:new]

  # match '/orders/purchase' => 'orders#purchase'

  resources :hosts do
    get :dashboard, on: :member
  end
  # match '/hosts/dashboard', to: "hosts#dashboard"
  # match '/animals/:animal_id/labels' => "animals#labels"
  # match '/animals/:animal_id/log' => "animals#log", as: :log

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, :cuts, :ranches, :butchers, :charges, :lines, :packages

  root to: 'animals#purchase'
end
