# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :auto_completes, only: [] do
  collection do
    get :mentions_users
  end
end
