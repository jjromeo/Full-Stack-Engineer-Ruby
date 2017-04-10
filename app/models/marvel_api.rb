require 'digest'
require 'net/http'
class MarvelApi
  VERSION = 'v1'
  HOST = "gateway.marvel.com"
  BASE_PATH = "/#{VERSION}/public"
  PUBLIC_KEY = '13f408c89f57ccc5b7754610e0fcc5ff'
  PRIVATE_KEY =  Rails.application.secrets.marvel_private_key
  ORDER_BY = "-onsaleDate"
  LIMIT = 90

  def get_comics(set: 1)
    offset = (set - 1) * LIMIT
    url = comics_url(offset: offset)
    fetch_results(url)
  end

  def get_comics_by_character(set: 1, name:)
    offset = (set - 1) * LIMIT
    id = get_character_id(name)
    url = character_comics_url(offset: offset, character_id: id)
    fetch_results(url)
  end

  private

  def get_character_id(name)
    fetch_results(characters_url(name)).first.fetch('id')
  end

  def characters_url(name)
    url('characters', { name: name })
  end

  def comics_url(offset: 0)
    url('comics', { orderBy: ORDER_BY, limit: LIMIT, offset: offset })
  end

  def character_comics_url(offset: 0, character_id:)
    url(
      "characters/#{character_id}/comics",
      { orderBy: ORDER_BY, limit: LIMIT, offset: offset }
    )
  end

  def fetch_results(url)
    JSON.parse(Net::HTTP.get(url)).fetch('data', {}).fetch('results', [])
  end

  def url(resource, params)
    URI::HTTPS.build(
      host: HOST,
      path: "#{BASE_PATH}/#{resource}",
      query: cred_params.merge(params).to_query
    )
  end

  def credential_params
    "ts=#{timestamp}&apikey=#{PUBLIC_KEY}&hash=#{hash}"
  end

  def cred_params
    {ts: timestamp, apikey: PUBLIC_KEY, hash: hash}
  end

  def timestamp
    Time.now.to_i
  end

  def hash
    Digest::MD5.hexdigest "#{timestamp}#{PRIVATE_KEY}#{PUBLIC_KEY}"
  end
end
