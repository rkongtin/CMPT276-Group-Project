Rails.application.routes.draw do
  
  #extra REST functions
  #bassically lets us have one for a specifc user, so /users/ID/action
  #instead of /users/action, which would share 1 page for all users
  #DO NOT TOUCH the stuff in here, if you want a better explanation, please read http://guides.rubyonrails.org/routing.html and ask if still confused
  resources :users do
    member do
      get 'makeAdmin'
      patch "makeAdmin_update"
      get 'changePassword'
      patch 'changePassword_update'
      get 'changeEmail'
      patch 'changeEmail_update'
      get 'settings'
      get 'home'
      get 'map'
    end
  end
  
  resources :houses do
    member do
      get 'info'
    end
  end
  
  
  get 'schools/index'
  get 'schools/new'
  get 'schools/show'
  get 'schools/edit'
  resources :schools
  
  
  get 'houses/index'
  get 'houses/new'
  get 'houses/show'
  get 'houses/edit'
  #get 'houses/info'
  resources :houses


  get 'static_pages/home' => 'static_pages#home'
  get 'static_pages/about' => 'static_pages#about'
  get 'static_pages/help' => 'static_pages#help'


  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get 'sessions/new'
  resources :sessions


  get 'users/index'
  resources :users
  
  
  root 'static_pages#home'  #default page of website (keep at bottom please)
  


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
