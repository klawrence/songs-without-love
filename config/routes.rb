Rails.application.routes.draw do
  resources :songs

  resources :artists

  root 'home#index'
end
