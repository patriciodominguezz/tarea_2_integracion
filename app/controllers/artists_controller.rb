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
    string = @artist_params["name"].strip
    @base = Base64.encode64(string).strip
    @identificador = @base[0..21]

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

  def create_album
    @album_params = params.permit(:id, :name, :genre)
    string = @album_params["name"].strip
    @base = Base64.encode64(string + ":" + @album_params["id"]).strip
    @identificador = @base[0..21]

    @artist = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @album_params["id"]
    @tracks = "https://tarea-2-taller-integracion.herokuapp.com/albums/" + @identificador + "/tracks"
    @self = "https://tarea-2-taller-integracion.herokuapp.com/albums/" + @identificador

    album = Album.new(id: @identificador, artist_id:  @album_params["id"], name: @album_params["name"], genre: @album_params["genre"], artist: @artist, tracks: @tracks, self: @self)
    if album.save
      render json:{
        status: 'Albums CREADO EXITOSAMENTE',
        data: album
      }, status: :ok
    else
      render json:{
        status: 'Album No creado',
        data: album
      }, status: :unprocessable_entity
    end

  end
end
