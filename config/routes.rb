Rails.application.routes.draw do
  resources :users, :except => [:create]
  resources :entries, :only => [:index, :show]
  get '/auth/:provider/callback', :to => 'auth#callback'
  root 'home#index'
end
