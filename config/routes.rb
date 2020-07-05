# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'
  devise_for :users

  get 'dashboard' => 'dashboard#index', :as => :user_root
  resources :posts, except: [:index]
end
