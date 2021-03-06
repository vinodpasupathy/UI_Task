Rails.application.routes.draw do
  get 'faces/index'

  get 'faces/vertical'

  get 'faces/compare'
  get 'faces/audit_report'
  get 'faces/audit_process'
  post 'faces/audit_process'
  get 'faces/spellcheck'

  get 'faces/uom'

  get 'faces/col_comp'
  
  get 'faces/result'
  get 'faces/help_ver'
  get 'faces/help_uom'
  get 'faces/duplication'  
  post 'faces/duplication_process'
  get 'faces/save_file'
  
  get 'faces/spell_process'

  get 'faces/uom_method'
 
  get 'faces/vert_process'

  get 'faces/vert_help'
  
  get 'faces/consicutive'

  get 'faces/consicutive_process'

  post 'faces/save_file'

  post 'faces/uom_method' 
  
  post 'faces/spell_process'

  post 'faces/vert_process'

  post 'faces/vert_help'
  
  post 'faces/result'
  post 'faces/help_ver'
  post 'faces/help_uom'
  post 'faces/consicutive'
  post 'faces/consicutive_process'
 
  get 'faces/welookup'
   
  post 'faces/welookup'

  get 'faces/pilot'
   
  post 'faces/pilot'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'faces#index'

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
