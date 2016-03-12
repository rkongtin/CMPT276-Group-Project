Rails.application.routes.draw do
  
  resources :users do
    member do
      get 'makeAdmin'
      patch "makeAdmin_update"
    end
  end
  
  
  
  get 'schools/index'

  get 'schools/new'

  get 'schools/show'

  get 'schools/edit'
  resources :schools  #really no idea why this specific thing is needed
  

  get 'static_pages/home' => 'static_pages#home'
  get 'static_pages/about' => 'static_pages#about'
  get 'static_pages/help' => 'static_pages#help'
  
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'sessions/new'

  get 'users/index'
  get 'users/home' => 'users#home'
  get 'users/login' => 'sessions#new'
  resources :users
  
  root 'static_pages#home'  #easier to find root down here
  
  #resources :login #this is now useless, don't know the reason login view caused so many issues
  
  #resources :users


  #root 'users#login'
  
  
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
