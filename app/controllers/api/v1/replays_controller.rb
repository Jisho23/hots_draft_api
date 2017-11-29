class Api::V1::ReplaysController < ApplicationController

  def index
    @replays = Replay.includes(:players).where(map_id: params['map_id'].to_i).order(id: :desc)
    render json: @replays.to_json(include: [:players])
  end

  # def index
  #   render json: Replay.where(map_id: params['map_id'].to_i).includes(:players).find_each(batch_size: 100).map do |replay|
  #     replay.to_json(includes: :players)
  #   end
  # end

  def show
    debugger
  end
end
