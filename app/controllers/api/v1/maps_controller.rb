class Api::V1::MapsController < ApplicationController

  def index
    @maps = Map.all
    render json: @maps.to_json
  end

  # def show
  #   @map = Map.find(params["id"])
  #   render json: @map.to_json(:include =>
  #     {:replays => {:include=>
  #       :players}}
  #     )
  # end
end
