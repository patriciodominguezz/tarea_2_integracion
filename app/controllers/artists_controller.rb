class ArtistsController < ApplicationController
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
end
