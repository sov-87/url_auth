Rails.application.routes.draw do
  get '/' => 'simple#index'
  post '/' => 'simple#index'
  
  get '/simple_get_url' => 'simple#index'
  post '/simple_get_url' => 'simple#index'
  
  get '/simple_url' => 'simple#index'
  post '/simple_url' => 'simple#index'
  
  get '/admin_url' => 'simple#index'
  post '/admin_url' => 'simple#index'
  
  post '/login' => 'login#index', as: :login
end
