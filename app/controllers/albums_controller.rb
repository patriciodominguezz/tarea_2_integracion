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
end
