# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_sessions, only: [:new, :create, :delete]
  namespace :back_office do
    resources :card_bundles, except: [:show]
  end

  get "/logout" => "user_sessions#delete"
  get "/login" => "user_sessions#new"

  root to: "user_sessions#new"
end
