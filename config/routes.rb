Rails.application.routes.draw do

  get 'home/about'
  devise_for :users
  root 'homes#top'
  get "homes/about" => "homes#about", as: "about"
  resources :books, only: [:new, :edit, :create,:update, :index, :show, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
