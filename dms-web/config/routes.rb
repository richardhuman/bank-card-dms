# frozen_string_literal: true

Rails.application.routes.draw do
  resources :user_logins, only: [:new, :create, :delete]
  namespace :back_office do
    resources :card_bundles
    resources :agents
  end

  get "/logout" => "user_logins#delete"
  get "/login" => "user_logins#new"

  root to: "user_logins#new"
end
