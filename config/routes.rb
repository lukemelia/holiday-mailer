HolidayMailer::Application.routes.draw do
  resources :people
  resources :households
  resources :notes
  resources :batches do
    member do
      put 'activate'
    end
  end
  
  get 'login' => 'sessions#new', :as => :login
  put 'sessions/facebook_oauth_token_update' => 'sessions#facebook_oauth_token_update', :as => :facebook_oauth_token_update
  delete 'sessions/logout' => 'sessions#destroy', :as => :logout

  # Home Page
  root :to => 'people#index'
end
