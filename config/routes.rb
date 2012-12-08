Isgetir::Application.routes.draw do


  root :to => 'jobs#index'

  #match 'jobs/new' => 'jobs#new'


  match 'jobs/search' => 'jobs#search'
  match 'jobs/search_autocomplete' => 'jobs#search_autocomplete'
  match '/ajaxing' => 'jobs#ajaxing', :as => 'ajaxing' # according to
  # ruby on rails by example (by Hartl), match '/smth' already gives us smth_path
  # ve bende denedim dogruymus.

  resources :jobs do

    member do
      post :notify_friend
    end
    collection do
      #get 'autocomplete'
      get :search
    end
    resources :comments
  end

  match 'users/admin_delete' => 'users#admin_delete', :as => 'admin_delete'

  # Notice match 'users/admin'... resources :users'dan once gelmeliymis
  match 'users/admin' => 'users#admin', :as => 'user_admin'

  match 'users/admin_edit_user' => "users#admin_edit_user", :as => 'admin_edit_user'

  match 'users/admin_change_password' => 'users#admin_change_password', :as => 'admin_change_password'

  resources :users

  match 'users/destroy' => "users#destroy"

  resource :session, :only => [:new, :create, :destroy] # , :only => [:new, :create, :destroy] added after reading rails by example

  resources :password_resets

  match '/login' => "sessions#new", :as => "login" # according to
  # ruby on rails by example (by Hartl), mathc '/smth' already gives us smth_path
  # ve bende denedim dogruymus.
  match '/logout' => "sessions#destroy", :as => "logout" # according to
  # ruby on rails by example (by Hartl), mathc '/smth' already gives us smth_path
  # ve bende denedim dogruymus.



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


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
