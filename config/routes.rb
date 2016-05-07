Rails.application.routes.draw do
  get '/auth/:provider/callback', :to => 'auth#callback'
  root 'home#index'
end
