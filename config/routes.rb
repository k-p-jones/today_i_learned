# frozen_string_literal: true

Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index', :as => :user_root
  root 'home#index'
  devise_for :users
end
