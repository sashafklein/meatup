Meatup2::Application.routes.draw do

  get   'about',          to: 'static_pages#about'
  get   'how',            to: 'static_pages#how'
  get   'welcome_email',  to: 'static_pages#welcome_email'
  get   'order_email',    to: 'static_pages#order_email'
  get   'purchase',       to: 'static_pages#purchase'
  get   'contact',        to: 'static_pages#contact'
  get   'signup',         to: 'users#new'
  get   'signin',         to: 'sessions#new'
  get   'incubation',     to: 'static_pages#incubation'
  get   'sale_list',      to: 'static_pages#list',        as:   :animal_list
  match 'signout',        to: 'sessions#destroy',         via:  :delete

  resources :animals do
    resources :orders, only: [:new]
    get :list, on: :member, as: :animal_list
    get :labels, on: :member
    get :log, on: :member
  end

  resources :orders, only: [:show, :create, :index] do
    post :rollback, on: :member
  end

  resources :hosts do
    get :dashboard, on: :member
  end
  # match '/hosts/dashboard', to: "hosts#dashboard"
  # match '/animals/:animal_id/labels' => "animals#labels"
  # match '/animals/:animal_id/log' => "animals#log", as: :log

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, :cuts, :ranches, :butchers, :charges, :lines, :packages

  root to: 'static_pages#purchase'
end
