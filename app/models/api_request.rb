class ApiRequest < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true

  def self.cache(url, cache_policy)
    find_or_initialize_by(url: url).cache(cache_policy) do |api_request|
      if block_given?
        yield(api_request)
      end
    end
  end

  def cache(cache_policy)
    if new_record? || updated_at < cache_policy.call || invalid?
      yield(self)
      update_attributes(updated_at: Time.zone.now)
    end
    self
  end

  def invalid?
    response_code != 200
  end

  def response_code
    response.present? ? JSON.parse(response).fetch("code") : nil
  end
end
