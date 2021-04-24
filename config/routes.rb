# frozen_string_literal: true

Rails.application.routes.draw do
  resources :auto_completes, only: [] do
    collection do
      get :mentions_users
    end
  end
end
