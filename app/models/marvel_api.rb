require 'digest'
require 'net/http'
class MarvelApi
  VERSION = 'v1'
  BASE_URL = "https://gateway.marvel.com/#{VERSION}/public"
  PUBLIC_KEY = '13f408c89f57ccc5b7754610e0fcc5ff'
  PRIVATE_KEY =  Rails.application.secrets.marvel_private_key
  ORDER_BY = "-onsaleDate"
  LIMIT = 100

  def comics_url
    URI("#{BASE_URL}/comics?ts=#{timestamp}&apikey=#{PUBLIC_KEY}&hash=#{hash}&orderBy=#{ORDER_BY}&limit=#{LIMIT}")
  end

  def get_comics
    JSON.parse(Net::HTTP.get(comics_url)).fetch('data', {}).fetch('results', [])
  end

  private

  def comics
  end

  def timestamp
    Time.now.to_i
  end

  def hash
    Digest::MD5.hexdigest "#{timestamp}#{PRIVATE_KEY}#{PUBLIC_KEY}"
  end
end
