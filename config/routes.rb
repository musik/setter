Setter::Application.routes.draw do
  wash_out :yun

  root :to => "home#index"
  devise_for :users
  resources :users
end
