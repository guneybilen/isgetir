Isgetir::Application.routes.draw do


  root :to => 'jobs#index'

  #match 'jobs/new' => 'jobs#new'

  match "/:locale/jobs" => "jobs#index"

  match ':locale/jobs/search' => 'jobs#search', :as => "search"
  match 'jobs/search_autocomplete' => 'jobs#search_autocomplete'
  match ':locale/search_by_cat_id' => 'jobs#search_by_cat_id', :as => 'search_by_cat_id' # according to
  # ruby on rails by example (by Hartl), match '/smth' already gives us smth_path
  # ve bende denedim dogruymus.

  match 'comment_destroy_path' => "comments#destroy"

  scope "/:locale" do
    resources :jobs do

      member do
        post :notify_friend
      end
      collection do
        get :search_autocomplete
        get :search
        get :ajaxing
        get :search_by_cat_id
      end
      resources :comments
    end
  end

  #scope "/:locale" do
  #  resources :jobs
  #end

=begin

  match 'users/admin_updated_user' => 'users#admin_updated_user', :as => 'admin_updated_user'

  match 'users/admin_update_user_interface' => 'users#admin_update_user_interface', :as => 'admin_update_user_interface'

  match 'users/admin_manage' => 'users#admin_manage', :as => 'admin_manage'

  # Notice match 'users/admin'... resources :users'dan once gelmeliymis
  match 'users/admin' => 'users#admin', :as => 'user_admin'

  match 'users/admin_edit_user' => "users#admin_edit_user", :as => 'admin_edit_user'

  match 'users/admin_change_password' => 'users#admin_change_password', :as => 'admin_change_password'

  resources :users
=end

  #match '/users/admin_manage:admin' => redirect('/jobs#index')   bu rule calismiyor.

  scope "/:locale" do
    resources :users do
      collection do
        put :admin_updated_user
        get :admin_update_user_interface
        get :admin_manage
        get :admin
        get :admin_edit_user
        put :admin_change_password
      end
    end
  end


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
