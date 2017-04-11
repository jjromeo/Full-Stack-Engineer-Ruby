require 'rails_helper'
RSpec.describe Favourite do
  it { should validate_uniqueness_of :comic_id }
end
