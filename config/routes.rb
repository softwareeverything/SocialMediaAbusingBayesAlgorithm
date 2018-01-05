Rails.application.routes.draw do
  resources :tweets
  root 'sayfalar#anasayfa'

  get ':controller(/:action(/:field))'
  post ':controller(/:action(/:field))'
  get '/auth/:provider/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end