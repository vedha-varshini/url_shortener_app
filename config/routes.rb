# config/routes.rb

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, path_names: {
    sign_out: 'sign_out'
  }, sign_out_via: [:delete, :get]

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

  authenticated :user, lambda { |u| u.admin? } do
    root to: redirect('/admin/users'), as: :admin_root
  end

  authenticated :user, lambda { |u| u.user? } do
    root to: 'shortened_urls#new', as: :authenticated_root
  end

  unauthenticated do
    root to: 'devise/sessions#new', as: :unauthenticated_root
  end
end
