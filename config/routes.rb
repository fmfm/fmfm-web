Rails.application.routes.draw do
  resources :users, :except => [:create]
  get '/auth/:provider/callback', :to => 'auth#callback'
  root 'home#index'
end
