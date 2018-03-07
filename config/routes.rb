Rails.application.routes.draw do

  root 'projects#index'
  resources :projects, only: [:new, :create, :show]
end
