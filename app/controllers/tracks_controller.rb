class TracksController < ApplicationController
  def index
    if request.get?
      tracks = Track.all;
      render json:tracks, status: 200
    else
      head 405
    end
  end

  def show 
    if request.get?
      @identificador = params[:id]
      track = Track.find_by(id: @identificador)
      if track.nil?
        head 404  
      else
      render json:track, status: 200
      end
    else
      head 405
    end
  end

  def destroy
    if request.delete?
      @identificador = params[:id]
      track = Track.where(id: @identificador)
      if track.empty?
        head 404
      else 
        track.delete_all
        head 204
      end
    else
      head 405
    end

  end

  def update
    if request.put?
      @identificador = params[:id]
      track = Track.find_by(id: @identificador)
      if track.nil?
        head 404
      else
      play = track["times_played"] + 1
      Track.where(id: @identificador).update_all(times_played: play)
      head 200
      end
    else
      head 405
    end
  end

end
