Rails.application.routes.draw do
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  devise_for :users
  resources :projects
  root to: "pages#home"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bugs do
     member do
     post :bug_status
    end
  end
end
