class Api::V1::ReplaysController < ApplicationController

  def index
    @replays = Replay.includes(:players).where(map_id: params['map_id'].to_i).order(id: :desc)
    render json: @replays.to_json(include: [:players])
  end

  def show
    debugger
  end
end
