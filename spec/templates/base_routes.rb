Rails.application.routes.draw do
  resources :articles do
    member do
      get :publish
    end
  end

  resources :users
  resources :companies, only: [:index]
end
