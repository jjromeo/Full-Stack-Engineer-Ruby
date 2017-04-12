class ComicWrapper
  IMAGE_VARIANT_SIZE = "portrait_incredible"
  YEAR_REGEX = /\(\d{4}\)/
  EDITION_REGEX = /#\d{1,2}/

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def as_json(options = {})
    {
      title: title,
      year: year,
      edition: edition,
      id: id,
      imageUrl: image_url,
      isFavourited: favourited?
    }
  end

  def title
    raw_title.try(:gsub, YEAR_REGEX, "").try(:gsub, EDITION_REGEX, "").try(:squeeze, " ")
  end

  def year
    raw_title.try(:[], YEAR_REGEX).try(:[], /\d{4}/)
  end

  def edition
    raw_title.try(:[], EDITION_REGEX)
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

  def raw_title
    data.fetch('title', nil)
  end

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
