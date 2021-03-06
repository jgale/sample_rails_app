SampleApp::Application.routes.draw do

  resources :users do
    # You might suspect that the URIs will look like /users/1/following and /users/1/followers, and that is exactly what
    # this code does. Since both pages will be showing data, we use get to arrange for the URIs to respond to GET requests
    # (as required by the REST convention for such pages), and the member method means that the routes respond to URIs containing
    # the user id. The other possibility, collection, works without the id, so that 'collection { get :tigers }'
    # which would make it like /users/tigers
    member do
      get :following, :followers
      # Creates paths like: following_user_path(user), followers_user_path(user)
    end
  end

  # Note that the routes for signin and signout are custom,
  # but the route for creating a session is simply the default (i.e., [resource name]_path).
  resources :sessions, only: [:new, :create, :destroy]

  resources :microposts, only: [:create, :destroy]
  #POST    /microposts     create        create a new micropost
  #DELETE  /microposts/1   destroy       delete micropost with id 1

  resources :relationships, only: [:create, :destroy]

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'static_pages#home'  
  # Could have done:
  #match '/',        to: 'static_pages#home'

  # Note, these create help_path and help_url for example
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  #  via: :delete indicates that it should be invoked using an HTTP DELETE request.
  match '/signout',  to: 'sessions#destroy', via: :delete

  #get "static_pages/home"
  #get "static_pages/help"
  #get "static_pages/about"
  #get "static_pages/contact"

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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
