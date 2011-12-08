Tabelia::Application.routes.draw do
  get 'logout' => "sessions#destroy", :as => 'logout'
  get 'login'  => "sessions#new",     :as => "login"

  match "admin",                      :controller => 'admin',    :action => 'dashboard',        :as => 'admin'
  match "admin/users",                :controller => 'admin',    :action => 'users_index',      :as => 'admin_users_index'
  match "admin/user/:username",       :controller => 'admin',    :action => 'user_edit',        :as => 'admin_user_edit'
  match "admin/user/update/:id",      :controller => 'admin',    :action => 'user_update',      :as => 'admin_user_update'
  match "admin/arts",                 :controller => 'admin',    :action => 'arts_index',       :as => 'admin_arts_index'
  match "admin/art/:slug",            :controller => 'admin',    :action => 'art_edit',         :as => 'admin_art_edit'
  match "admin/art/update/:id",       :controller => 'admin',    :action => 'art_update',       :as => 'admin_art_update'
  match "admin/photos",               :controller => 'admin',    :action => 'photo_index',       :as => 'admin_photo_index'
  match "admin/photo/:slug",          :controller => 'admin',    :action => 'photo_edit',         :as => 'admin_photo_edit'
  match "admin/photo/update/:id",     :controller => 'admin',    :action => 'photo_update',       :as => 'admin_photo_update'
  
  
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
  
  match "user/confirmation/:c1/:c2",  :controller => 'users',    :action => 'confirmation',     :as => 'user_confirmation'
  match "user/:username",             :controller => 'users',    :action => 'show',             :as => "user_profile"
  match "user/:username/art",         :controller => 'arts',     :action => 'user_art_show',    :as => "user_arts"
  match "user/:username/photos",      :controller => 'photos',   :action => 'user_photos_show', :as => "user_photos"
  match "user/:username/followers",   :controller => 'users',    :action => 'followers',        :as => "user_followers"
  match "user/:username/following",   :controller => 'users',    :action => 'following',        :as => "user_following"
  match "art/:slug",                  :controller => 'arts',     :action => 'show',             :as => "art_profile"
  match "art/:slug/likes",            :controller => 'arts',     :action => 'likes',            :as => "art_likes"
  match "art/:slug/edit",             :controller => 'arts',     :action => 'edit',             :as => "edit_art"

  match "photo/:slug",                :controller => 'photos',   :action => 'show',             :as => "photo_profile"
  match "photo/:slug/likes",          :controller => 'photos',   :action => 'likes',            :as => "photo_likes"
  match "photo/:slug/edit",           :controller => 'photos',   :action => 'edit',             :as => "edit_photo"
  match "photo/:slug/update",         :controller => 'photos',   :action => 'update',           :as => "update_photo"
  match "color/(:color)",             :controller => 'color',    :action => 'index',            :as => "color_index"

  match "search",                     :controller => 'search',   :action => 'index',            :as => "search"

  match "style/:slug",                :controller => 'category', :action => 'show',             :as => 'category_show'
  match "idiom/:slug",                :controller => 'idioms',   :action => 'show',             :as => 'idiom_show'
  match "style/:slug",                :controller => 'category', :action => 'show',             :as => "category"
  match "subject/:slug",              :controller => 'subject',  :action => 'show',             :as => "subject"
  match "tecnique/:slug",             :controller => 'tecniques',:action => 'show',             :as => "tecnique"

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
  match 'help',                        :controller => 'pages',   :action => 'help',         :as => 'page_help'
  match 'help/big_art',                :controller => 'pages',   :action => 'big_art',      :as => 'page_big_art'
  match 'help/how_to_sell',            :controller => 'pages',   :action => 'how_to_sell',  :as => 'page_how_to_sell'
  match 'help/how_to_buy',             :controller => 'pages',   :action => 'how_to_buy',   :as => 'page_how_to_buy'
  match 'help/shopping',               :controller => 'pages',   :action => 'shopping',  :as => 'page_shopping'
  match 'help/paintings',      :controller => 'pages',   :action => 'publish_paintings',  :as => 'page_publish_paintings'
  match 'help/photos',         :controller => 'pages',   :action => 'publish_photos',     :as => 'page_publish_photos'
      
  match 'confirmation',                :controller => 'pages',   :action => 'confirmation', :as => 'page_confirmation'
  
  match 'send_confirmation',           :controller => 'users',   :action => 'resend_confirmation', :as => 'resend_conf'
  
  match 'language',                    :controller => 'locale',  :action => 'change',       :as => 'change_locale'
  match 'locale/:language',            :controller => 'locale',  :action => 'set',          :as => 'set_locale'        
  
  match 'profile/basic',               :controller => 'profile', :action => 'basic',        :as => 'profile_basic'
  match 'profile/about',               :controller => 'profile', :action => 'about',        :as => 'profile_about'
  match 'profile/avatar',              :controller => 'profile', :action => 'avatar',       :as => 'profile_avatar'
  match 'profile/privacy',             :controller => 'profile', :action => 'privacy',      :as => 'profile_privacy'
  match 'profile/services',            :controller => 'profile', :action => 'services',     :as => 'profile_services'
  match 'profile/billing',             :controller => 'profile', :action => 'billing',      :as => 'profile_billing'
  
  #match 'user/:username/edit',         :controller => 'users',   :action => 'edit',         :as => 'edit_user'
  
  resources :order   #, :only => [:new, :create]
  resources :addresses, :only => [:new, :create, :edit, :update, :destroy]
  resources :arts,   :only => [:index, :new, :create, :update]
  resources :photos, :only => [:index, :new, :create, :update]
  resources :sessions
  resources :users, :only => [:index, :edit, :create, :update] do
    get 'page/:page', :action => :index, :on => :collection
  end
  
  # FACEBOOK specific
  match 'channel/:locale', :controller => 'pages', :action => 'channel'
  
  match 'robots.(:format)' => 'robots#index'
  root :to => 'pages#index'

  match '*a', :to => 'pages#not_found'



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
