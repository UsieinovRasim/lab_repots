# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  resources :lab_reports

  root 'users#index'
end
