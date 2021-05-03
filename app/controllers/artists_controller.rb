class ArtistsController < ApplicationController


  require "base64"

  def index
    if request.get?
    artists = Artist.all;
    render json:artists, status: 200
    else
      head 405
    end
  end

  def show
    if request.get?
      @identificador = params[:id]
      artist = Artist.find_by(id: @identificador)
      if artist.nil?
        head 404
      else
        render json:artist, status: 200
      end
    else
      head 405
    end
  end

  def show_albums
    if request.get?
      @variable = params[:id]
      artist = Artist.find_by(id: @variable)
      if artist.nil?
        head 404
      else
        album = Album.where(artist_id: @variable)
        render json:album, status: 200
      end
    else
      head 405
    end
  end

  def show_tracks
    if request.get?
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
    else
      head 405
    end
  end

  def create
    if request.post?
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
    else
      head 405
    end
  end

  def create_album
    if request.post?
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
    else
      head 405  
    end
  end

  def destroy
    if request.delete?
      @identificador = params[:id]
      artist = Artist.where(id: @identificador)
      albums = Album.where(artist_id: @identificador)
      if artist.empty?
        head 404
      else 
        (0.. albums.length()-1).each do |i|
          album_id = albums[i]['id']
          tracks = Track.where(album_id: album_id)
          tracks.delete_all
        end
        albums.delete_all
        artist.delete_all
        head 204
      end
    else
      head 405
    end
  end

  def update
    if request.put?
      @identificador = params[:id]
      artist = Artist.find_by(id: @identificador)
      if artist.nil?
        head 404
      else
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
        head 200
      end
    else
      head 405
    end
  end


  
end
