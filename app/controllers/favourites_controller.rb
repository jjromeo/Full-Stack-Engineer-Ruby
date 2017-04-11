class FavouritesController < ApplicationController
  def create
    Favourite.create(comic_id: params[:comic_id].to_i)
  end
end
