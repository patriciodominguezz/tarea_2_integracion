Rails.application.routes.draw do


  get 'artists', to: 'artists#index'
  get 'artists/:id', to: 'artists#show'
  get 'artists/:id/albums', to: 'artists#show_albums'
  #get 'artists/:id/tracks', to: 'artists#show_tracks'

  post 'artists', to: 'artists#create'
  post 'artists/:id/albums', to: 'artists#create_album'

 

  get 'albums', to: 'albums#index'
  get 'albums/:id', to: 'albums#show'
  get 'albums/:id/tracks', to: 'albums#show_tracks'

  post 'albums/:id/tracks', to: 'albums#create'
 
  
  get 'tracks', to: 'tracks#index'
  get 'tracks/:id', to: 'tracks#show'

end
