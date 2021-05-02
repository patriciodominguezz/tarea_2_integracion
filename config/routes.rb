Rails.application.routes.draw do


  get 'artists', to: 'artists#index'
  get 'artists/:id', to: 'artists#show'
  get 'artists/:id/albums', to: 'artists#show_albums'
  get 'artists/:id/tracks', to: 'artists#show_tracks'

  post 'artists', to: 'artists#create'
  post 'artists/:id/albums', to: 'artists#create_album'

  delete 'artists/:id', to: 'artists#destroy'

  put 'artists/:id/albums/play', to: 'artists#update'
 

  get 'albums', to: 'albums#index'
  get 'albums/:id', to: 'albums#show'
  get 'albums/:id/tracks', to: 'albums#show_tracks'

  post 'albums/:id/tracks', to: 'albums#create'
  
  delete 'albums/:id', to: 'albums#destroy'

  put 'albums/:id/tracks/play', to: 'albums#update'
  
  get 'tracks', to: 'tracks#index'
  get 'tracks/:id', to: 'tracks#show'

  delete 'tracks/:id', to: 'tracks#destroy'

  put 'tracks/:id/play', to: 'trackss#update'



end
