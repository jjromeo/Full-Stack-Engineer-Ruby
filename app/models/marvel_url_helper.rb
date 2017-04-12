class MarvelUrlHelper
  VERSION = 'v1'
  HOST = "gateway.marvel.com"
  BASE_PATH = "/#{VERSION}/public"
  PUBLIC_KEY = Rails.application.secrets.marvel_public_key
  PRIVATE_KEY = Rails.application.secrets.marvel_private_key

  attr_reader :order_by, :limit

  def initialize(order_by:, limit:)
    @order_by = order_by
    @limit = limit
  end

  def comics_url(offset: 0)
    url('comics', { orderBy: order_by, limit: limit, offset: offset })
  end

  def character_comics_url(offset: 0, character_id:)
    url(
      "characters/#{character_id}/comics",
      { orderBy: order_by, limit: limit, offset: offset }
    )
  end

  def characters_url(character)
    url('characters', { name: character, limit: 1 })
  end

  def credential_params
    {ts: timestamp, apikey: PUBLIC_KEY, hash: hash}
  end

  private

  def url(resource, params)
    URI::HTTPS.build(
      host: HOST,
      path: "#{BASE_PATH}/#{resource}",
      query: params.to_query
    )
  end

  def timestamp
    Time.now.to_i
  end

  def hash
    Digest::MD5.hexdigest "#{timestamp}#{PRIVATE_KEY}#{PUBLIC_KEY}"
  end
end
