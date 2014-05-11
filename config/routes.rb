Rails.application.routes.draw do
  resources :artists

  root 'home#index'
end
