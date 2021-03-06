SocialHelpApp::Application.routes.draw do

  resources :proposals
  resources :project_reports, only: [:index, :create] do
    member do
      put 'approve'
      put 'reject'
    end
  end

  resources :issues do
    member do
      put "change_status"
    end
    collection do
      get "interested_ngos"
      get "pending_issues"
      get "completed_issues"
    end
  end

  resources :fiscal_stats
  resources :projects do
    collection do
      get 'completed_projects'
      get 'pending_proposed_projects'
      get 'ongoing_projects'
      get 'reject_project'
      get 'project_reports'
      get 'pending_fund'
      get 'fund_log'
    end
    member do
      get 'close_project'
      post 'release_fund'
    end
  end

  resource :users, only: [:edit] do
    collection do
      patch "update_profile"
      post "change_image"
      get 'user_profile'
    end
  end
  devise_for :users, controllers: {registrations: "sign_up", sessions: "sessions"}

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # devise_scope :user do
  #   root to: "devise/sessions#new"
  # end

  get "profile" => "users#profile"
  get "dashboard" => "users#dashboard"
  get "my_projects" => "users#my_projects"
  get "welfare_funds" => "users#welfare_funds"
  get "my_proposals" => "proposals#my_proposals"
  get "my_issues" => "issues#my_issues"
  get "donate" => "users#donate"
  post "receive_donation" => "users#receive_donation"
  get "my_donations" => "users#my_donations"
  get "reject_proposal" => "proposals#reject_proposal"
  get "view_donations" => "users#view_donations"
  root to: "users#home"

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
