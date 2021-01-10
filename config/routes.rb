Rails.application.routes.draw do
  resources :participants
  resources :games
  resources :sheets
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
