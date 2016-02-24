Rails.application.routes.draw do
  root 'application#angular'

  namespace :api do
    post '/auth/:provider',      to: 'auth#authenticate'

    resources :categories do
      get :tree, on: :collection
    end
    resources :items do
      get :image, on: :member
    end
  end
end
