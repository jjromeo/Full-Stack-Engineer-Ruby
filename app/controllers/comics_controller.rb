class ComicsController < ApplicationController
  def index
    @comics = MarvelApi.new.get_comics
    @comics = @comics.map {|comic| ComicWrapper.new(comic) }
    #@images = {
      #heart_off: image_path('heart_off'),
      #heart_hover: image_path('heart_hover'),
      #heart_on: image_path('heart_on')
    #}
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
