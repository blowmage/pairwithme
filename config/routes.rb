PairWithMe::Application.routes.draw do
  root :to => "home#index"

  # Devise
  devise_for :users
  devise_scope :user do
    # Sessions
    get    'login'  => 'devise/sessions#new',     :as => :new_user_session
    post   'login'  => 'devise/sessions#create',  :as => :user_session
    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    # Password
    post   'reset_password'      => 'devise/passwords#create', as: :user_password
    get    'reset_password/new'  => 'devise/passwords#new',    as: :new_user_password
    get    'reset_password/edit' => 'devise/passwords#edit',   as: :edit_user_password
    put    'reset_password'      => 'devise/passwords#update', as: :user_password
    # Registration
    get    'register'       => 'devise/registrations#new',     as: :new_user_registration
    post   'register'       => 'devise/registrations#create',  as: :new_user_registration
    get    'profile/edit'   => 'devise/registrations#edit',    as: :edit_user_registration
    post   'profile'        => 'devise/registrations#create',  as: :user_registration
    put    'profile'        => 'devise/registrations#update',  as: :user_registration
    delete 'profile'        => 'devise/registrations#destroy', as: :user_registration
    get    'profile/cancel' => 'devise/registrations#cancel',  as: :cancel_user_registration
  end

  # Profile
  get "profile" => "profile#index", as: :profile

  # Account
  get  ":username" => "account#index", as: :account
  post ":username/sessions/:id/reserve" => "account#reserve", as: :reserve

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
