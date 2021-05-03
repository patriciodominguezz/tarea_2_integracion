class TracksController < ApplicationController
  def index
    tracks = Track.all;
    render json:tracks, status: 200
  end

  def show 
    @identificador = params[:id]
    track = Track.find_by(id: @identificador)
    if track.nil?
      head 404  
    else
    render json:track, status: 200
    end
  end

  def destroy
    @identificador = params[:id]
    track = Track.where(id: @identificador)
    if track.empty?
      head 404
    else 
      track.delete_all
      head 204
    end

  end

  def update
    @identificador = params[:id]
    track = Track.find_by(id: @identificador)
    if track.nil?
      head 404
    else
    play = track["times_played"] + 1
    Track.where(id: @identificador).update_all(times_played: play)
    head 200
    end
  end

end
