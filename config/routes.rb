InfographiclyApp::Application.routes.draw do
  
  root :to => 'pages#home'
  
  get '/logout' => 'sessions#logout', :as => :logout
  get '/login' => 'sessions#new', :as => :new_session
  post "/sessions" => 'sessions#create'

  
  get 'home' => "pages#home"

  get 'about' => "pages#about"

  get 'how' => "pages#how"

  get 'contact' => "pages#contact"

  get 'signup' => "pages#signup"

  get 'login' => "pages#login"

  resources :genres

  resources :sources

  resources :articles
  
  get 'users/login' => 'users#login', :as => :login
  get 'users/logout' => 'users#logout', :as => :logout
  
  resources :users

end
