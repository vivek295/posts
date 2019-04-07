Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    resources :comments, except: [:destroy]
    collection do
      get 'archived', to: 'posts#archived_posts', as: :archived
    end
    get 'restore', to: 'posts#restore', as: :restore
    delete 'permanent_destroy', to: 'posts#permanent_destroy', as: :destroy
  end

  resources :comments, only: [:destroy] do
    get 'restore', to: 'comments#restore', as: :restore
    delete 'permanent_destroy', to: 'comments#permanent_destroy', as: :destroy
  end
end
