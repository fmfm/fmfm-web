Rails.application.routes.draw do
  resources :users,     :except => [:create]
  resources :user_tokens
  resources :entries,   :only => [:index, :show]
  resources :bookmarks, :only => [:create]
  get '/auth/:provider/callback', :to => 'auth#callback'
  root 'home#index'
end
