Rails.application.routes.draw do
  resources :cards
  resources :users

  get '/input', to: 'card#input'

end
