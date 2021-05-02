class ArtistsController < ApplicationController

  require "base64"

  def index
    artists = Artist.all;
    render json:artists, status: :ok
  end

  def show 
    @identificador = params[:id]
    artist = Artist.where(id: @identificador)[0]
    render json:{
      status: 'Artist id',
      data: artist
    }, status: :ok
  end

  def show_albums
    @variable = params[:id]
    album = Album.where(artist_id: @variable)
    render json:{
      status: 'Album',
      data: album
    }, status: :ok
  end

  def create

    @artist_params = params.permit(:name, :age)
    string = @artist_params["name"]
    @identificador = Base64.encode64(string).strip

    @albums = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @identificador + "/albums"
    @tracks = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @identificador + "/tracks"
    @self = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @identificador
    
    artist = Artist.new(id: @identificador, name: @artist_params["name"], age: @artist_params["age"], albums: @albums, tracks: @tracks, self: @self)
    if artist.save
      render json:{
        status: 'ARTISTA CREADO EXITOSAMENTE',
        data: artist
      }, status: :ok
    else
      render json:{
        status: 'ARTISTA No creado',
        data: artist
      }, status: :unprocessable_entity
    end
  end
end
