class Favourite < ApplicationRecord

  validates_uniqueness_of :comic_id

  def self.favourited?(comic_id)
    Favourite.pluck(:comic_id).include?(comic_id)
  end
end
