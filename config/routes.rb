Rails.application.routes.draw do
  root 'sessions#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'registrations#new'
  post '/signup', to: 'registrations#create'

  resources :shortened_urls, only: [:new, :create, :index]

  namespace :admin do
    resources :users do
      member do
        get :urls, to: 'users#urls'
        get :confirm_delete
      end
    end
  end

  get '/:short_code', to: 'redirect#show', as: :short
end