require 'digest'
require 'net/http'
class MarvelApi
  ORDER_BY = "-onsaleDate"
  LIMIT = 30
  CACHE_POLICY = lambda { 2.days.ago }

  attr_reader :character, :wrapper, :set,  :url_helper

  def initialize(character: nil, set: 1, wrapper: ComicWrapper, url_helper: MarvelUrlHelper)
    @wrapper = wrapper
    @character = character
    @set = set
    @url_helper = MarvelUrlHelper.new(order_by: ORDER_BY, limit: LIMIT)
  end

  def comics
    fetched_comics.map {|comic| wrapper.new(comic) }
  end

  private

  def fetched_comics
    character.present? ? get_comics_by_character : get_all_comics
  end

  def get_comics_by_character
    offset = (set - 1) * LIMIT
    id = get_character_id
    url = url_helper.character_comics_url(offset: offset, character_id: id)
    get_parsed_results(url)
  end

  def get_all_comics
    offset = (set - 1) * LIMIT
    url = url_helper.comics_url(offset: offset)
    get_parsed_results(url)
  end

  def get_character_id
    get_parsed_results(url_helper.characters_url(character)).first.try(:fetch, 'id')
  end

  def get_parsed_results(url)
    JSON.parse(get_url_with_caching(url)).fetch('data', {}).fetch('results', [])
  end

  def get_url_with_caching(url)
    req = ApiRequest.cache(url.to_s, CACHE_POLICY) do |api_request|
      url.query = url_helper.credential_params.to_query + "&" + url.query
      response = Net::HTTP.get(url).force_encoding("ASCII-8BIT").encode('UTF-8', undef: :replace, replace: '')
      api_request.update_attributes(response: response)
    end
    req.response
  end
end
