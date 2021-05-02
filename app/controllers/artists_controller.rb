class ArtistsController < ApplicationController


  require "base64"

  def index
    artists = Artist.all;
    render json:artists, status: 200
  end

  def show 
    @identificador = params[:id]
    artist = Artist.find_by(id: @identificador)
    if artist.nil?
      head 404
    else
      render json:artist, status: 200
    end
  end

  def show_albums
    @variable = params[:id]
    artist = Artist.find_by(id: @variable)
    if artist.nil?
      head 404
    else
      album = Album.where(artist_id: @variable)
      render json:album, status: 200
    end
  end

  def show_tracks
    @identificador = params[:id]
    artist = Artist.find_by(id: @identificador)
    if artist.nil?
      head 404
    else
      album = Album.where(artist_id: @identificador)
      tracks = []
      (0.. album.length()-1).each do |i|
        variable = Track.where(album_id: album[i]["id"])
        (0.. variable.length()-1).each do |j|
          tracks.append(variable[j])
        end
      end
      render json:tracks, status: 200
    end

  end

  def create 
    @artist_params = params.permit(:name, :age)
    if @artist_params["name"].nil? or @artist_params["age"].nil? or !@artist_params["name"].is_a?(String) or !@artist_params["age"].is_a?(Integer)
      head 400

    else

      string = @artist_params["name"]
      @base = Base64.encode64(string).strip
      @identificador = @base[0..21]

      @albums = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @identificador + "/albums"
      @tracks = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @identificador + "/tracks"
      @self = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @identificador
      
      duplicado = Artist.find_by(id: @identificador)
    
      if duplicado.nil?
        artist = Artist.new(id: @identificador, name: @artist_params["name"], age: @artist_params["age"], albums: @albums, tracks: @tracks, self: @self)
        if artist.save
          render json:artist, status: 201     #####listo
        end
      else
        render json:duplicado, status: 409
      end
    end
  end

  def create_album
    @album_params = params.permit(:id, :name, :genre)
    @artist_exist = Artist.find_by(id: @album_params["id"])
    if @artist_exist.nil?
      head 422
    else
      if @album_params["name"].nil? or @album_params["genre"].nil? or !@album_params["genre"].is_a?(String) or !@album_params["name"].is_a?(String)
        head 400
      else
        string = @album_params["name"]
        @base = Base64.encode64(string + ":" + @album_params["id"]).strip
        @identificador = @base[0..21]

        @artist = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + @album_params["id"]
        @tracks = "https://tarea-2-taller-integracion.herokuapp.com/albums/" + @identificador + "/tracks"
        @self = "https://tarea-2-taller-integracion.herokuapp.com/albums/" + @identificador

        duplicado = Album.find_by(id: @identificador)

        if duplicado.nil?
          album = Album.new(id: @identificador, artist_id:  @album_params["id"], name: @album_params["name"], genre: @album_params["genre"], artist: @artist, tracks: @tracks, self: @self)
          if album.save
            render json:album, status: 201     
          end
        else
          render json:duplicado, status: 409

        end

      end

    end

  end

  def destroy
    @identificador = params[:id]
    artist = Artist.where(id: @identificador)
    if artist.delete_all
      render json:{
        status: 'DELETE EXITOSO',
        data: artist
      }, status: 204

    else
      render json:{
        status: 'NO HUBO DELETE',
        data: artist
      }, status: :unprocessable_entity
    end
  
  end

   def update
    @identificador = params[:id]
    albums = Album.where(artist_id: @identificador)
    (0.. albums.length()-1).each do |i|
      album_id = albums[i]['id']
      tracks = Track.where(album_id: album_id)
      (0.. tracks.length()-1).each do |j|
        id = tracks[j]["id"]
        play = tracks[j]["times_played"] + 1
        Track.where(id: id, album_id: album_id).update_all(times_played: play)
      end
    end
   end

end
