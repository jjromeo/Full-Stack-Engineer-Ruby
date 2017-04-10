class ComicsController < ApplicationController
  def index
    @comics = MarvelApi.new.get_comics
    @comics = @comics.map {|comic| ComicWrapper.new(comic) }
  end
end
