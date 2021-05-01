class TracksController < ApplicationController
  def index
    tracks = Track.all;
    render json:tracks, status: :ok
  end

  def show 
    @identificador = params[:id]
    track = Track.where(id: @identificador)
    render json:{
      status: 'Track id',
      data: track
    }, status: :ok
  end

end
