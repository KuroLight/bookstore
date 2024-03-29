Bookstore::Application.routes.draw do
  get 'admin' => 'admin#index'

  controller :sessions do
    # 创建一个signup路径，同时将signup与new user页面关联起来,
    # by TYF, 2012, 05, 30
    # link_to就用get 
    get     'signup' => :sign_up
    # button_to就用post, 但是post是有问题的,get和post不同，这是下面login有两个的原因
    # post     'signup' => :sign_up
    # end
    get     'login'   => :new
    post    'login'   => :create
    delete  'logout'  => :destroy
  end
  # get "admin/index"
# 
  # get "sessions/new"
# 
  # get "sessions/create"
# 
  # get "sessions/destroy"

  resources :users

  resources :orders

  resources :line_items

  resources :carts

  get "store/index"

  # add this by TYF, 2012.05.16
  resources :products do
    get :who_bought, :on => :member
  end
  # end

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
  # just remember to delete public/index.html.            <-----------remember to do this! -by TYF, 2012.05.09
  # =>                                                     $ rm public/index.html
  # root :to => 'welcome#index'
  
  # add this by TYF, 2012.05.09
  root :to => 'store#index', :as => 'store'
  # end by TYF
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
