Rails.application.routes.draw do


  get 'artists', to: 'artists#index'
  get 'artists/:id', to: 'artists#show'
  get 'artists/:id/albums', to: 'artists#show_albums'
  #get 'artists/:id/tracks', to: 'artists#show_tracks'

  get 'albums', to: 'albums#index'
  get 'albums/:id', to: 'albums#show'
  get 'albums/:id/tracks', to: 'albums#show_tracks'
 
  
  get 'tracks', to: 'tracks#index'
  get 'tracks/:id', to: 'tracks#show'

end
