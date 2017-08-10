Rails.application.routes.draw do
  get 'links/index'

  get 'links/new'

  get 'links/show'

  get 'links/edit'

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end
  resources :users, only: [:new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
