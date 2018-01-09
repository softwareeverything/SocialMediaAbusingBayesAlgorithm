Rails.application.routes.draw do
  get 'tweets/index'
  get 'tweets/new'
  get 'tweets/show'
  get 'tweets/tweetlerim'

  root 'sayfalar#anasayfa'

  get ':controller(/:action(/:field))'
  post ':controller(/:action(/:field))'
  get '/auth/:provider/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end