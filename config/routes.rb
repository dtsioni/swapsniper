Rails.application.routes.draw do
  root 'users#matches'
  resources :passwords,
    controller: 'clearance/passwords',
    only: [:create, :new]

  resource :session,
    controller: 'clearance/sessions',
    only: [:create]

  resources :users,
    controller: 'users',
    only: Clearance.configuration.user_actions do
      resource :password,
        controller: 'clearance/passwords',
        only: [:create, :edit, :update]
    end

  resources :origins, only: [:create, :new]
  resources :destinations, only: [:create, :new]
  resources :users, only: [:show, :edit, :update]

  get 'users/:id/matches', to: 'users#matches'
  get 'users/:id/deactivate', to: 'users#deactivate', as: 'deactivate'
  get 'users/:id/activate', to: 'users#activate', as: 'activate'

  get '/sign_in' => 'clearance/sessions#new', as: 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', as: 'sign_out'

  if Clearance.configuration.allow_sign_up?
    get '/sign_up' => 'users#new', as: 'sign_up'
  end
end
