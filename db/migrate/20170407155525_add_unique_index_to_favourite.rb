class AddUniqueIndexToFavourite < ActiveRecord::Migration[5.0]
  def change
    add_index :favourites, :comic_id, unique: true
  end
end
