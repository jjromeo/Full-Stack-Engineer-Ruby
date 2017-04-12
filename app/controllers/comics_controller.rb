class ComicsController < ApplicationController
  def index
    @comics = MarvelApi.new.comics
  end

  def fetch
    character = params[:character]
    set =  params[:set] || 1

    @comics = MarvelApi.new(character: character, set: set.to_i).comics
    render json: @comics
  end
end
