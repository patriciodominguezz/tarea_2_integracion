class AlbumsController < ApplicationController
  def index
    albums = Album.all;
    render json:albums, status: :ok 
  end

  def show 
    @identificador = params[:id]
    album = Album.where(id: @identificador)[0]
    render json:{
      status: 'Album id',
      data: album
    }, status: :ok
  end

  def show_tracks
    @variable = params[:id]
    track = Track.where(album_id: @variable)
    render json:{
      status: 'Tracks',
      data: track
    }, status: :ok
  end 

  def create
    @track_params = params.permit(:id, :name, :duration)
    string = @track_params["name"].strip
    @base = Base64.encode64(string + ":" + @track_params["id"]).strip
    @identificador = @base[0..21]
    @album = "https://tarea-2-taller-integracion.herokuapp.com/albums/" + @track_params["id"]
    @self = "https://tarea-2-taller-integracion.herokuapp.com/tracks/" + @identificador

    ######artista_id

    variable = Album.where(id: @track_params["id"])
    artist_id = variable[0]["artist_id"]
    @artist = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + artist_id

    track = Track.new(id: @identificador, album_id:  @track_params["id"], name: @track_params["name"], 
    duration: @track_params["duration"], times_played: 0, artist: @artist, album: @album, self: @self)

    if track.save
      render json:{
        status: 'track CREADO EXITOSAMENTE',
        data: track
      }, status: :ok
    else
      render json:{
        status: 'track No creado',
        data: track
      }, status: :unprocessable_entity
    end
   



  end
end
