Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'comics#index'
  resources :comics, only: :index do
    collection do
      get :fetch
    end
  end
end
