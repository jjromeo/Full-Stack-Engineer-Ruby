require 'digest'
require 'net/http'
class MarvelApi
  VERSION = 'v1'
  BASE_URL = "https://gateway.marvel.com/#{VERSION}/public"
  PUBLIC_KEY = '13f408c89f57ccc5b7754610e0fcc5ff'
  PRIVATE_KEY =  Rails.application.secrets.marvel_private_key

  def url(resource)
    URI("#{BASE_URL}/#{resource}?ts=#{timestamp}&apikey=#{PUBLIC_KEY}&hash=#{hash}")
  end

  def get_comics
    JSON.parse(Net::HTTP.get(url('comics')))['data']['results']
  end

  private
  def timestamp
    Time.now.to_i
  end

  def hash
    Digest::MD5.hexdigest "#{timestamp}#{PRIVATE_KEY}#{PUBLIC_KEY}"
  end
end
