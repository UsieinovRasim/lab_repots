Rails.application.routes.draw do
  resources :users#, only: %i[ index show new create ]
  resources :lab_reports#, only: %i[ show edit update create ]

  root "users#index"
end
