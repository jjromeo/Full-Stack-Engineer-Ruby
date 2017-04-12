class ComicWrapper
  IMAGE_VARIANT_SIZE = "portrait_incredible"
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def as_json(options = {})
    {
      title: title,
      id: id,
      imageUrl: image_url,
      isFavourited: favourited?
    }
  end

  def title
    data.fetch('title', nil)
  end

  def id
    data.fetch('id', nil)
  end

  def image_url
    "#{raw_image_url}/#{IMAGE_VARIANT_SIZE}.#{image_extension}"
  end

  def favourited?
    Favourite.favourited?(id)
  end

  private

  def raw_image_url
    thumbnail.fetch('path', nil)
  end

  def image_extension
    thumbnail.fetch('extension', nil)
  end

  def thumbnail
    data.fetch('thumbnail', {})
  end
end
