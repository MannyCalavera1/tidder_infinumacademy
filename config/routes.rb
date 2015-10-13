Rails.application.routes.draw do

  devise_for :users
  root 'static_pages#index'

  get 'user/settings' => 'users#settings'
  post 'user' => 'users#update'
  patch 'user' => 'users#update'


  resources :subreddits, only: [:index, :new, :create, :show], shallow: true do
    post 'subreddit_subscriptions' => 'subreddit_subscriptions#create'
    delete 'subreddit_subscriptions' => 'subreddit_subscriptions#destroy'
    resources :posts, except: :index do
      post 'upvotes' => 'upvotes#create'
      resources :comments, only: :create
    end
  end

  namespace :api do
    api version: 1, module: 'v1', allow_prefix: 'v' do
      resources :subreddits, except: [:new, :edit] do
        resources :posts, except: [:new, :edit], shallow: true do
          post :upvote, on: :member
          resources :comments, only: [:index, :create, :destroy]
        end
      end
    end
  end


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
