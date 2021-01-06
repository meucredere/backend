Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :api do
    namespace :v1 do
      post '/probes/move', to: 'probes#move'
      get '/probes/reset', to: 'probes#reset'
      get '/probes/current_position', to: 'probes#current_position'
    end
  end
end
