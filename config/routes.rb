Rails.application.routes.draw do
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }
  #devise_for :users
  resources :projects do
    resources :bugs
  end

  root to: "pages#home"
 
  devise_for :users
  
 
end
