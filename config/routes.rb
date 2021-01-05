Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/move', to: 'probes#move'
      get '/reset', to: 'probes#reset'
      get '/current_position', to: 'probes#current_position'
    end
  end
end
