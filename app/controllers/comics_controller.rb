class ComicsController < ApplicationController
  def index
    @comics = MarvelApi.new.get_comics
    @comics = @comics.map {|comic| ComicWrapper.new(comic) }
  end

  def fetch
    set =  params[:set].to_i || 1
    @comics = MarvelApi.new.get_comics(set: set)
    @comics = @comics.map {|comic| ComicWrapper.new(comic) }
    render json: @comics
  end
end
