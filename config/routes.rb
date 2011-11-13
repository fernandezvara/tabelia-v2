Tabelia::Application.routes.draw do
  get "locale/set"

  get "invoice/show"

  get "messages/notifications"
  get "messages/new"
  get "messages/create"
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

  
  match "admin",                      :controller => 'admin',    :action => 'dashboard',        :as => 'admin'
  match "admin/users",                :controller => 'admin',    :action => 'users_index',      :as => 'admin_users_index'
  match "admin/user/:username",       :controller => 'admin',    :action => 'user_edit',        :as => 'admin_user_edit'
  match "admin/user/update/:id",      :controller => 'admin',    :action => 'user_update',      :as => 'admin_user_update'
  match "admin/arts",                 :controller => 'admin',    :action => 'arts_index',       :as => 'admin_arts_index'
  match "admin/art/:slug",            :controller => 'admin',    :action => 'art_edit',         :as => 'admin_art_edit'
  match "admin/art/update/:id",       :controller => 'admin',    :action => 'art_update',       :as => 'admin_art_update'
  
  # messaging routes
  match "messages",                   :controller => 'messages', :action => 'inbox',            :as => 'inbox'
  match "messages/view/:slug",        :controller => 'messages', :action => 'view',             :as => 'message_view'
  match "messages/reply/:slug",       :controller => 'messages', :action => 'reply',            :as => 'message_reply'
  match "messages/new/:username",     :controller => 'messages', :action => 'new',              :as => 'new_message'
  match "messages/create",            :controller => 'messages', :action => 'create',           :as => 'create_message'
  match "messages/delete/:slug",      :controller => 'messages', :action => 'delete',           :as => 'delete_message'
  match "messages/view/:slug/delete", :controller => 'messages', :action => 'delete_from_view', :as => 'delete_message_from_view'
  
  # routes for javascript events...
  match "action/follow/:username",    :controller => 'actions',  :action => 'follow',           :as => 'action_follow'
  match "action/unfollow/:username",  :controller => 'actions',  :action => 'unfollow',         :as => 'action_unfollow'
  match "action/like/:slug",          :controller => 'actions',  :action => 'like',             :as => 'action_like'
  match "action/unlike/:slug",        :controller => 'actions',  :action => 'unlike',           :as => 'action_unlike'
  
  match "category/:slug",             :controller => 'category', :action => 'show',             :as => 'category_show'
  
  match "user/:username",             :controller => 'users',    :action => 'show',             :as => "user_profile"
  match "user/:username/art",         :controller => 'arts',     :action => 'user_art_show',    :as => "user_arts"
  match "user/:username/followers",   :controller => 'users',    :action => 'followers',        :as => "user_followers"
  match "user/:username/following",   :controller => 'users',    :action => 'following',        :as => "user_following"
  match "art/:slug",                  :controller => 'arts',     :action => 'show',             :as => "art_profile"
  match "art/:slug/likes",            :controller => 'arts',     :action => 'likes',            :as => "art_likes"
  match "art/:slug/edit",             :controller => 'arts',     :action => 'edit',             :as => "edit_art"

  match "color/:color",               :controller => 'color',    :action => 'index',            :as => "color_index"

  match "search",                     :controller => 'search',   :action => 'index',            :as => "search"

  match "category/:slug",             :controller => 'category', :action => 'show',             :as => "category"


  match 'user/comment/:username',     :controller => 'comments', :action => 'create',           :as => 'comment_user'
  match 'view/comments/:username/:last',    :controller => 'comments', :action => 'view',          :as => 'view_more_comments'
  
  match 'art/comment/:slug',           :controller => 'comments', :action => 'create_art',        :as => 'comment_art'
  match 'art/comments/:slug/:last',    :controller => 'comments', :action => 'view_art',          :as => 'view_more_art_comments'
  
  #cart
  match 'cart',                        :controller => 'cart',      :action => 'index',            :as => 'cart'
  match 'art/:slug/add_to_cart',       :controller => 'arts',      :action => 'add_to_cart',      :as => 'add_to_cart'
  match 'cart/add',                    :controller => 'cart',      :action => 'create',           :as => 'cart_create'
  match 'cart/price',                  :controller => 'cart',      :action => 'price',            :as => 'cart_price'
  match 'cart/checkout',               :controller => 'cart',      :action => 'checkout',         :as => 'cart_checkout'
  
  # addresses
  match 'address/:type/:address',      :controller => 'addresses', :action => 'address',          :as => 'addresses_address'
  
  match 'page_not_found',              :controller => 'pages',     :action => 'not_found',        :as => 'not_found'
  
  # User creation
   # OLD: get 'signup' => "users#new",        :as => 'signup'
  match 'signup',                      :controller => 'users',  :action => 'signup',        :as => 'signup'
  match 'signup/tabelia',              :controller => 'users',  :action => 'new',           :as => 'new_user'
  match 'auth/:provider/callback',     :controller => 'users',  :action => 'new_provider',  :as => 'new_user_provider'
  match 'auth/failure',                :controller => 'users',  :action => 'failure'
  #match 'signup/:provider',            :controller => 'users',  :action => 'new_provider',  :as => 'new_user_provider'
  
  #match 'auth/:provider/callback',    :controller => 'sessions', :action => 'create_external',  :as => 'create_external'
  
  match 'terms',                       :controller => 'pages',   :action => 'terms',        :as => 'page_terms'
  match 'privacy',                     :controller => 'pages',   :action => 'privacy',      :as => 'page_privacy'
  match 'jobs',                        :controller => 'pages',   :action => 'jobs',         :as => 'page_jobs'
  
  match 'language',                    :controller => 'locale',  :action => 'change',       :as => 'change_locale'
  match 'locale/:language',            :controller => 'locale',  :action => 'set',          :as => 'set_locale'        
  
  resources :order   #, :only => [:new, :create]
  resources :addresses, :only => [:new, :create, :edit, :update, :destroy]
  resources :arts, :only => [:index, :new, :create, :update]
  resources :sessions
  resources :users, :only => [:index, :create, :edit, :update] do
    get 'page/:page', :action => :index, :on => :collection
  end
  root :to => 'pages#index'

  #match '*a', :to => 'pages#not_found'



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
