Rails.application.routes.draw do

  resources :stripe
  mount StripeEvent::Engine => '/stripe-Webhooks'
  post '/stripe/webhook' => 'stripe#webhook'
  
  get 'database/add_salesforce_account'

  root 'welcome#index'

  get 'core/run'
  get 'core/apps'
  get 'core/index'
  get 'core/logout'
  get 'core/add_user'
  post 'core/invite_user' => 'core#invite_user'
  get 'core/change_settings'
  post 'core/change_settings' => 'core#change_settings'

  post '/callback/receive_data' => 'callback#receive_data'
  
  get 'welcome/signup'
  get 'welcome/check_user'
  get 'welcome/setup'
  get 'welcome/new_user'
  get 'welcome/add_user'
  post 'welcome/add_user' => 'welcome#add_user'

  get 'elements/callback'
  
  resources :welcome do
    post :pw_mail, :on => :collection
  end
  post '/welcome/check_user' => 'welcome#check_user'
  post '/welcome/signup' => 'welcome#signup'
  get '/welcome/pw_email'
  post '/welcome/pw_email' => 'welcome#pw_email'
  
  post '/welcome/invite_user' => 'welcome#invite_user'
  
  resources :elements do
    member do
      get :callback
    end
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  get '/auth/:provider/callback', to: 'sessions#create'

  namespace :admin do
    resources :users
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
