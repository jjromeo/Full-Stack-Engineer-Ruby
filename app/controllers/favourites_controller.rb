class FavouritesController < ApplicationController
  def create
    favourite = Favourite.new(comic_id: params[:comic_id].to_i)
    if favourite.save
      head 201
    else
      head 400
    end
  end

  def destroy
    Favourite.where(comic_id: params[:comic_id]).first.destroy
    head 204
  end
end
