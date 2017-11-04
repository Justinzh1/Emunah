Rails.application.routes.draw do
  resources :users
  get '/user/home' => 'users#home', :as => 'user_home'

  resources :families
  get '/families/:id/new_person' => 'families#new_person', :as => 'new_person'
  post '/families/:id/add_person' => 'families#add_person', :as => 'add_person'
  get '/person/:id/' => 'people#show', :as => 'show_person'
  get '/person/:id/edit' => 'people#edit'
  patch '/person/:id/edit' => 'people#update'
  
  # Entry point, login and logout.
  get '/home' => 'home#index', :as => 'home'
  post '/home/login' => 'home#login', :as => 'login'
  get '/home/logout' => 'home#logout', :as => 'logout'
  get '/dashboard' => 'home#dash', :as => 'dash'
  root :to => redirect('/home')
end
