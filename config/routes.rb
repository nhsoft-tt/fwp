Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'fwp#index'

  resources :fwp do
    collection do 
      get "one"
      get "two"
      get "three"
      get "four"
      get "five"
    end
  end

  resources :cases do
    member do
      get :get_json
    end
  end

  resources :case_results
end
