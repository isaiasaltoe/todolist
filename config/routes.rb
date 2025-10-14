Rails.application.routes.draw do
  get "pages/home"
  devise_for :users
  resources :tasks
  root "pages#home"
end
