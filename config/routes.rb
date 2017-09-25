Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'weights#index'
  resources :weights
  resources :competitions do
    get '/description', to: 'competitions#description'
    patch '/join', to: 'competitions#join'
  end
  resources :goals
end
