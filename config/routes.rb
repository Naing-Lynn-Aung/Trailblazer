Rails.application.routes.draw do

  root 'login#login'
  post '/login', to: 'login#action_login'
  delete '/logout', to: 'login#logout'
  get 'password/reset', to: 'login#password_reset'
  post 'password/reset', to: 'login#password_reset_send'
  get '/reset_password', to: 'login#reset_password'
  patch '/reset_password', to: 'login#reset_password_send'
  resources :users do
    collection do 
      get :profile
      get :edit_profile
      put :edit_profile, to: 'users#update_profile'
      get :edit_password
      put :edit_password, to: 'users#update_password'
    end
  end
  resources :posts do
    collection do
      get :search
      get :export
      get :csv_format
      get :import
      post :import, to: 'posts#importCsv'
      get :filter
    end
  end

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
