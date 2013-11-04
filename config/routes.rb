ProjectFs::Application.routes.draw do
  devise_for :users

  root to: 'projects#index'

  resources :projects do
    resources :directories do
      member do
        get 'files'
        post 'files'
        post 'upload'
      end
      resources :documents
    end
  end


end
