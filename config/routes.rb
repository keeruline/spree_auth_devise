Spree::Core::Engine.routes.draw do
  devise_for :user,
             :class_name => 'Spree::User',
             :controllers => { :sessions => 'spree/user_sessions',
                               :registrations => 'spree/user_registrations',
                               :passwords => 'spree/user_passwords' },
             :skip => [:unlocks, :omniauth_callbacks],
             :path_names => { :sign_out => 'logout' }

  resources :users, :only => [:edit, :update]

  devise_scope :user do
    get '/login' => 'user_sessions#new'
    get '/logout' => 'user_sessions#destroy'
    get '/signup' => 'user_registrations#new'
  end

  get '/checkout/registration' => 'checkout#registration'
  put '/checkout/registration' => 'checkout#update_registration'

  match '/orders/:id/token/:token' => 'orders#show', :via => :get, :as => :token_order

  resource :session do
    member do
      get :nav_bar
    end
  end

  resource :account, :controller => 'users'

  namespace :admin do
    resources :users
  end
end
