Rails.application.routes.draw do
  get 'publics/homes'
  get 'publics/top'
  get '/about' => "public/homes#about"

  root to: "public/homes#top"

scope module: :public do
  get '/customers/my_page' => "customers#show", as: "my_page"
  get '/customers/information/edit' => "customers#edit", as: "information/edit"
  patch '/customers' => "customers#update"
  get '/cutomers/confirm' => "customers#confirm", as: "confirm"
  patch '/customers/unsubscribe' => "customers#unsubscribe", as: "unsubscribe"
  resources :items, only: [:index, :show]
  resources :shipping_addresses, only: [:index, :edit, :update, :create, :destroy]
  delete '/cart_items/destroy_all' => "cart_items#destroy_all"
  resources :cart_items, only: [:index, :create, :update, :destroy]
  post '/orders/confirm' => "orders#confirm"
  get '/orders/thanks' => "orders#thanks"
  resources :orders, only: [:new, :create, :index, :show]
  end


namespace :admin do
    get '/' => "homes#top"
    resources :genres, only: [:index, :edit, :update, :create]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    patch '/orders_details/:id' => "orders_details#update_making", as: "update_making"
  end

  # 顧客用
  # URL /customers/sign_in....
  devise_for :customers, skip:[:passwords], controllers:{
    registrations: "public/registrations" ,
    sessions: 'public/sessions'
  }
  # 管理者用
  # URL /admin/sign_in...
  devise_for :admin, skip:[:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
