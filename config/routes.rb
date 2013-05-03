Setter::Application.routes.draw do
  #wash_out :yun
  wash_out :api

  root :to => "home#index"
  devise_for :users
  resources :users
end
