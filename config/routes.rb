Setter::Application.routes.draw do
  #wash_out :yun
  wash_out :api

  post "test" => "home#test"
  root :to => "home#index"
  devise_for :users
  resque_constraint = lambda do |request|
    Rails.env.development? or 
    (request.env['warden'].authenticate? and
      request.env['warden'].user.has_role?(:admin))
  end
  constraints resque_constraint do
    mount Resque::Server.new, :at => "/resque"
  end
  resources :users
end
