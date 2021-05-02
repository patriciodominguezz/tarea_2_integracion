class AlbumsController < ApplicationController
  def index
    albums = Album.all;
    render json:albums, status: :ok 
  end

  def show 
    @identificador = params[:id]
    album = Album.find_by(id: @identificador)
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

    variable = Album.find_by(id: @track_params["id"])
    artist_id = variable["artist_id"]
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

  def destroy
    @identificador = params[:id]
    album = Album.where(id: @identificador)
    if album.delete_all
      render json:{
        status: 'DELETE EXITOSO',
        data: album
      }, status: 204

    else
      render json:{
        status: 'NO HUBO DELETE',
        data: album
      }, status: :unprocessable_entity
    end
  
  end
  
  def update
    @identificador = params[:id]
    tracks = Track.where(album_id: @identificador)
    (0.. tracks.length()-1).each do |i|
      id = tracks[i]["id"]
      play = tracks[i]["times_played"] + 1
      Track.where(id: id, album_id: @identificador).update_all(times_played: play)
    end
  end

end
