Rails.application.routes.draw do
  ActiveAdmin.routes(self)
    root :to => 'welcomes#index'
	resources :users
	get "home" => "users#home", :as => "home"
	resources :airplanes
	get "ticket" => "airplanes#ticket", :as => "ticket"
	match "book" => "airplanes#book", :as => "book", :via => [:get,:post]
	get "logout" => "users#destroy_login", :as => "logout"
    match "login" => "users#verify_login", :as => "login", :via => [:get,:post]
    match "password" => "users#password", :as => "password", :via => [:get,:post]
    match "reset" => "users#reset", :as => "reset", :via => [:get,:post]
    match "reset_link/:id" => "users#reset_link", :as => "reset_link", :via => [:get,:post]
    match "success_link" => "users#success_link", :as => "success_link", :via => [:get,:post]
    post "finalize" => "users#finalize", :as => "finalize"
    get "search" => "airplanes#search", :as => "search"
    get "pnr" => "airplanes#pnr", :as => "pnr"
    get "flight" => "airplanes#flight", :as => "flight"
    post "available" => "airplanes#available", :as => "available"
    get "payment/:id" => "airplanes#payment", :as => "payment"
    match "success/:id" => "airplanes#success", :as => "success", :via => [:get,:post]
end
