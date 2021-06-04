# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :back_office do
    resources :card_bundles
    resources :agents
  end
end
