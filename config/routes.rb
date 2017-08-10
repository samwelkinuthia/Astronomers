Rails.application.routes.draw do
  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :users, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
