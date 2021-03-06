class AlbumsController < ApplicationController
  def index
    if request.get?
      albums = Album.all;
      render json:albums, status: 200
    else
      head 405
    end
  end

  def show 
    if request.get?
      @identificador = params[:id]
      album = Album.find_by(id: @identificador)
      if album.nil?
        head 404
      else
        render json:album, status: 200
      end
    else
      head 405
    end

  end

  def show_tracks
    if request.get?
      @variable = params[:id]
      album = Album.find_by(id: @variable)
      if album.nil?
        head 404
      else
      track = Track.where(album_id: @variable)
      render json:track, status: 200
      end
    else
      head 405
    end
  end 

  def create
    if request.post?
      @track_params = params.permit(:id, :name, :duration)
      @album_exist = Album.find_by(id: @track_params["id"])
      if @album_exist.nil?
        head 422
      else
        if @track_params["name"].nil? or @track_params["duration"].nil? or !@track_params["name"].is_a?(String) or !@track_params["duration"].is_a?(Float)
          head 400
        else
          string = @track_params["name"].strip
          @base = Base64.encode64(string + ":" + @track_params["id"]).strip
          @identificador = @base[0..21]
          @album = "https://tarea-2-taller-integracion.herokuapp.com/albums/" + @track_params["id"]
          @self = "https://tarea-2-taller-integracion.herokuapp.com/tracks/" + @identificador

          variable = Album.find_by(id: @track_params["id"])
          artist_id = variable["artist_id"]
          @artist = "https://tarea-2-taller-integracion.herokuapp.com/artists/" + artist_id


          duplicado = Track.find_by(id: @identificador)

          if duplicado.nil?
            track = Track.new(id: @identificador, album_id:  @track_params["id"], name: @track_params["name"], 
            duration: @track_params["duration"], times_played: 0, artist: @artist, album: @album, self: @self)
            if track.save
              render json:track, status: 201
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
      album = Album.where(id: @identificador)
      track = Track.where(album_id: @identificador)
      if album.empty?
        head 404
      else
        track.delete_all
        album.delete_all
        head 204
      end
    else
      head 405
    end
  end
  
  def update
    if request.put?
      @identificador = params[:id]
      album = Album.find_by(id: @identificador)
      if album.nil?
        head 405
      else
        tracks = Track.where(album_id: @identificador)
        (0.. tracks.length()-1).each do |i|
          id = tracks[i]["id"]
          play = tracks[i]["times_played"] + 1
          Track.where(id: id, album_id: @identificador).update_all(times_played: play)
        end
        head 200
      end
    else
      head 405
    end
  end

end
