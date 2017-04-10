class ComicsController < ApplicationController
  def index
    @comics = MarvelApi.new.get_comics.slice(0, 5)
    @comics = @comics.map {|comic| ComicWrapper.new(comic) }
  end
end
