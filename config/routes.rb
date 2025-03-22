Rails.application.routes.draw do
  root to: "restaurants#index"
  resources :restaurants do
    resources :galleries
    resource :menu do
      resources :dishes
    end
  end
  get "up" => "rails/health#show", as: :rails_health_check
end
