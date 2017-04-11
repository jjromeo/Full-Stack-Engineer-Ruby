class FavouritesController < ApplicationController
  def create
    favourite = Favourite.new(comic_id: params[:comic_id].to_i)
    if favourite.save
      render json: { success: true }
    else
      render json: { error: true }
    end
  end
end
