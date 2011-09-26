Tabelia::Application.routes.draw do

  get "actions/follow"

  get "actions/unfollow"

  get "actions/like"

  get "actions/unlike"

  get "category/show"
  get "arts/show"
  get "arts/new"
  get "arts/create"
  get "arts/edit"
  get "arts/update"
  get "pages/help"
  
  get 'logout' => "sessions#destroy", :as => 'logout'
  get 'login'  => "sessions#new",     :as => "login"
  
  # routes for javascript events...
  match "action/follow/:username",   :controller => 'actions',  :action => 'follow',          :as => 'action_follow'
  match "action/unfollow/:username", :controller => 'actions',  :action => 'unfollow',        :as => 'action_unfollow'
  
  match "category/:slug",            :controller => 'category', :action => 'show',            :as => 'category_show'
  
  match "user/:username",            :controller => 'users',    :action => 'show',            :as => "user_profile"
  match "user/:username/art",        :controller => 'arts',     :action => 'user_art_show',   :as => "user_arts"
  match "art/:slug",                 :controller => 'arts',     :action => 'show',            :as => "art_profile"
  match "category/:slug",            :controller => 'category', :action => 'show',            :as => "category"
  match 'auth/:provider/callback',   :controller => 'sessions', :action => 'create_external', :as => 'create_external'

  match 'user/comment/:username',    :controller => 'comments', :action => 'create',          :as => 'comment_user'
  match 'view/comments/:username/:last',    :controller => 'comments', :action => 'view',          :as => 'view_more_comments'
  
  resources :arts, :only => [:new, :create, :edit, :update]
  resources :sessions
  resources :users do
    get 'page/:page', :action => :index, :on => :collection
  end
  root :to => 'pages#index'



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
  # match ':controller(/:action(/:id(.:format)))'
end
