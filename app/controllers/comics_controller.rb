class ComicsController < ApplicationController
  def index
    @comics = MarvelApi.new.get_comics
    @comics = @comics.map {|comic| ComicWrapper.new(comic) }
  end

  def fetch
    character = params[:character]
    set =  params[:set].to_i || 1
    if character.present?
      @comics = MarvelApi.new.get_comics_by_character(set: set, name: character)
    else
      @comics = MarvelApi.new.get_comics(set: set)
    end
    @comics = @comics.map {|comic| ComicWrapper.new(comic) }
    render json: @comics
  end
end
