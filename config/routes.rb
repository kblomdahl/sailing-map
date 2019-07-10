Rails.application.routes.draw do
  root 'maps#index'
  resources :mails, only: [:create]
end
