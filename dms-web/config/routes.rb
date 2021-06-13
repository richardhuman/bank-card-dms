# frozen_string_literal: true

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  resources :user_sessions, only: [:new, :create, :destroy]

  namespace :back_office do
    resources :campaigns, except: [:show]
    resources :bundles, except: [:show]
    resources :users, except: [:show]
    get "dashboard" => "dashboard#index"
  end

  namespace :agents do
    resources :bundles, except: [:show]
    resources :users, except: [:show]
  end

  get "user_invitations/claim/:invitation_code" => "user_invitations#claim"

  get "/logout" => "user_sessions#destroy"
  get "/login" => "user_sessions#new"

  root to: "user_sessions#new"
end
